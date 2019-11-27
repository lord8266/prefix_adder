module tb;
  initial begin $dumpfile("build/prefix_adder.vcd"); $dumpvars(0,tb); end
  
 	reg [15:0] term0,term1;
 	reg cin;
	wire [15:0] sum;
	wire cout;

 	prefix_adder p0(term0,term1,cin,sum,cout);
 	initial begin
 	term0 = 16'h6978;
	term1 = 16'h61a8;
	cin=0;
	#10;
	term0 = 16'h7530;
	term1 = 16'h7d00;
	cin=0;
	#10;
	term0 = 16'hee48;
	term1 = 16'h5208;
	cin=1;
	#10;
	term0 = 16'hafc8;
	term1 = 16'h7148;
	cin=1;
	#10;
	term0 = 16'h07d0;
	term1 = 16'h3e80;
	cin=0;
	#10;
	term0 = 16'habe0;
	term1 = 16'h7918;
	cin=1;
	#10;
	term0 = 16'hc738;
	term1 = 16'h3a98;
	cin=0;
	#10;
	term0 = 16'ha7f8;
	term1 = 16'h36b0;
	cin=1;
	#10;
	term0 = 16'hf618;
	term1 = 16'h6d60;
	cin=0;
	#10;
	term0 = 16'hfa00;
	term1 = 16'h2710;
	cin=1;
	#10;

 	end
 	
endmodule