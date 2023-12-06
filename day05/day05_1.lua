#!/usr/bin/env lua

locs={}
maps={}
path={}
seeds={}

npaths = 0
nseeds = 0

map=""
for line in io.lines(arg[1]) do
  if line:find("seeds:") then
    for seed in line:gmatch("%d+") do
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
  path[from] = to
  npaths = npaths + 1
end

for i, seed in ipairs(seeds) do
  map="seed"

  for j=1,npaths,1 do
   local nextseed = seed

   target = path[map]
   local mapname = map .. "-to-" .. target
   for k, v in pairs(maps[mapname]) do
     local drs = v[1]
     local srs = v[2]
     local len = v[3]

     if seed >= srs then
       if seed < srs + len then
	 nextseed = seed - srs + drs
       end
     end

   end
   map = target
   seed = nextseed
  end
  table.insert(locs, seed)
end

table.sort(locs)
print(locs[1])
