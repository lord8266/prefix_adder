module tb;
  initial begin $dumpfile("build/prefix_adder.vcd"); $dumpvars(0,tb); end
  
 	reg [15:0] term0,term1;
 	reg cin;
	wire [15:0] sum;
	wire cout;

 	prefix_adder p0(term0,term1,cin,sum,cout);
 	initial begin
 	term0 = 16'habc1;
	term1 = 16'h0002;
	cin = 0;
	#10;
 	end
 	
endmodule
