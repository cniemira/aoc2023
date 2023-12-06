#!/usr/bin/env lua

maps={}
path={}
seeds={}

npaths = 0
nseeds = 0

map=""
for line in io.lines(arg[1]) do
  if line:find("seeds:") then
    for seed in line:gmatch("%d+") do
--      print("seed:"..seed)
      table.insert(seeds, tonumber(seed))
      nseeds = nseeds + 1
    end
  elseif line:find("map:") then
    map=line:match("%S+")
    maps[map]={}
  elseif line:len() > 0 then
    local thismap={}
    for i in line:gmatch("%d+") do
      table.insert(thismap, tonumber(i))
    end
    table.insert(maps[map], thismap)
  end
end

for k,v in pairs(maps) do
  from=k:match("%w+")
  to=k:reverse():match("%w+"):reverse()
  --print("map:"..to.."->"..from)
  path[to] = from
  npaths = npaths + 1
end

loc=0
seed=0
while true do

  map="location"
  for j=npaths,1,-1 do 
    local nextseed = seed
    target=path[map]
    local mapname = target .. "-to-" .. map
    --print("check:"..seed.." in "..mapname)
    for k, v in pairs(maps[mapname]) do
        local drs = v[1]
        local srs = v[2]
        local len = v[3]

        --print(" is "..seed.." in range "..drs.."+"..len)
        if seed >= drs then
          if seed < drs + len then
            nextseed = seed - drs + srs
            --print(" yes!")
            goto breakout
          end
        end
    end
    ::breakout::
    --print("  next seed is: "..nextseed)

    map=target
    seed = nextseed

    if map == "seed" then
      for i=1,nseeds,2 do
        minseed = seeds[i]
        maxseed = minseed + seeds[i+1]
        if seed >= minseed then
          if seed < maxseed then
            goto continue
          end 
        end
      end
      --print("  not a known seed:"..seed)
    end
  end

  loc = loc + 1
  seed = loc
end

::continue::
print(loc) 
