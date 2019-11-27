module tb;
  initial begin $$dumpfile("build/prefix_adder.vcd"); $$dumpvars(0,tb); end
  
 	reg [$n:0] term0,term1;
 	reg cin;
	wire [$n:0] sum;
	wire cout;

 	prefix_adder p0(term0,term1,cin,sum,cout);
 	initial begin
 	$test
 	end
 	
endmodule