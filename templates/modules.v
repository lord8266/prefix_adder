module preprocess(input wire x,y,output wire p,g);
	assign p=x|y;
	assign g=x&y;
endmodule

module process(input wire p2,g2,p1,g1,output wire p,g);
	assign p=p1&p2;
	assign g=g2 | (p2&g1);
endmodule

module add(input wire x,y,g,output wire sum);
	assign sum = x^y^g;
endmodule

module prefix_adder(
	input wire [$n:0] term0,term1,
	input wire cin,
	output wire [$n:0] sum,
	output wire cout
	);
			
	wire [$npp:0]p,g;
    $code
	assign cout = term0[15]&$cout | term1[15]&$cout | term0[15]&term1[15];
endmodule
	 
	

