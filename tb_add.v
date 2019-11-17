module tb;
  initial begin $dumpfile("build/prefix_adder.vcd"); $dumpvars(0,tb); end
  
 	reg [7:0] term0,term1;
 	reg cin;
	wire [7:0] sum;
	wire cout;

 	prefix_adder p0(term0,term1,cin,sum,cout);
 	initial begin
 	term0 = 8'b00000000;
	term1 = 8'b00001111;
	cin = 0;
	#10
	term0 = 8'b11110000;
	term1 = 8'b00001111;
	cin = 1;
	#10
	term0 = 8'b11110000;
	term1 = 8'b00001111;
	cin = 0;
	#10
	term0 = 8'b10110100;
	term1 = 8'b01001001;
	cin = 0;
	#10
	term0 = 8'b00000000;
	term1 = 8'b11101111;
	cin = 0;
	#10
	term0 = 8'b10010000;
	term1 = 8'b01001001;
	cin = 0;
	#10
	term0 = 8'b10010000;
	term1 = 8'b01001001;
	cin = 0;
 	end
 	
endmodule
