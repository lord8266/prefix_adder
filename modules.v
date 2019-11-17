module preprocess(input wire x,y,output wire p,g);
	assign p=x+y;
	assign g=x&y;
endmodule

module add(input wire x,y,g,output wire sum);
	assign sum = x^y^g;
endmodule

module process(input wire p2,g2,p1,g1,output wire p,g);
	assign p=p1&p2;
	assign g=g2+p2&g1;
endmodule

module prefix_adder(
	input wire [7:0] term0,term1,
	input wire cin,
	output wire [7:0] sum,
	output wire cout
	);
			
	wire [6:0]p,g;
	preprocess p0(term0[0],term1[0],p[0],g[0]);
	preprocess p1(term0[1],term1[1],p[1],g[1]);
	preprocess p2(term0[2],term1[2],p[2],g[2]);
	preprocess p3(term0[3],term1[3],p[3],g[3]);
	preprocess p4(term0[4],term1[4],p[4],g[4]);
	preprocess p5(term0[5],term1[5],p[5],g[5]);
	preprocess p6(term0[6],term1[6],p[6],g[6]);
	
	wire l0_p0,l0_g0,l0_p1,l0_g1,l0_p2,l0_g2,l0_p3,l0_g3;
	wire l1_p0,l1_g0,l1_p1,l1_g1,l1_p2,l1_g2,l1_p3,l1_g3;
	wire l2_p0,l2_g0,l2_p1,l2_g1,l2_p2,l2_g2,l2_p3,l2_g3;

	process l0_pr0(p[0],g[0],1'b0,cin,l0_p0,l0_g0);
	process l0_pr1(p[2],g[2],p[1],g[1],l0_p1,l0_g1);
	process l0_pr2(p[4],g[4],p[3],g[3],l0_p2,l0_g2);
	process l0_pr3(p[6],g[6],p[5],g[5],l0_p3,l0_g3);

	process l1_pr0(p[1],g[1],l0_p0,l0_g0,l1_p0,l1_g0);
	process l1_pr1(l0_p1,l0_g1,l0_p0,l0_g0,l1_p1,l1_g1);
	process l1_pr2(p[5],g[5],l0_p2,l0_g2,l1_p2,l1_g2);
	process l1_pr3(l0_p3,l0_g3,l0_p2,l0_g2,l1_p3,l1_g3);

	process l2_pr0(p[3],g[3],l1_p1,l1_g1,l2_p0,l2_g0);
	process l2_pr1(l0_p2,l0_g2,l1_p1,l1_g1,l2_p1,l2_g1);
	process l2_pr2(l1_p2,l1_g2,l1_p1,l1_g1,l2_p2,l2_g2);
	process l2_pr3(l1_p3,l1_g3,l1_p1,l1_g1,l2_p3,l2_g3);

	add a0(term0[0],term1[0],cin,sum[0]);
	add a1(term0[1],term1[1],l0_g0,sum[1]);
	add a2(term0[2],term1[2],l1_g0,sum[2]);
	add a3(term0[3],term1[3],l1_g1,sum[3]);
	add a4(term0[4],term1[4],l2_g0,sum[4]);
	add a5(term0[5],term1[5],l2_g1,sum[5]);
	add a6(term0[6],term1[6],l2_g2,sum[6]);
	add a7(term0[7],term1[7],l2_g3,sum[7]);
	assign cout = l2_g3;
endmodule
	 
	

