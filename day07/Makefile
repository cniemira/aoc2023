sources :=  $(wildcard *.c)
programs := $(sources:.c=)

%: %.c clean
	${CC} ${LINKERFLAG} $< -o $@
	./$@

all:    $(programs)

clean:
	-rm $(programs)
