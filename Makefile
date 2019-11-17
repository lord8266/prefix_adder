all:compile wave

compile:dir
	iverilog *.v -o build/prefix_adder
	vvp build/prefix_adder

wave:
	gtkwave build/prefix_adder.vcd

dir:
	if [ ! -d "build" ]; then \
	mkdir build; \
	fi;

