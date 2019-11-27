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
	input wire [15:0] term0,term1,
	input wire cin,
	output wire [15:0] sum,
	output wire cout
	);
			
	wire [14:0]p,g;
    wire l0_p0,l0_g0, l0_p1,l0_g1, l0_p2,l0_g2, l0_p3,l0_g3, l0_p4,l0_g4, l0_p5,l0_g5, l0_p6,l0_g6, l0_p7,l0_g7;
	wire l1_p0,l1_g0, l1_p1,l1_g1, l1_p2,l1_g2, l1_p3,l1_g3, l1_p4,l1_g4, l1_p5,l1_g5, l1_p6,l1_g6, l1_p7,l1_g7;
	wire l2_p0,l2_g0, l2_p1,l2_g1, l2_p2,l2_g2, l2_p3,l2_g3, l2_p4,l2_g4, l2_p5,l2_g5, l2_p6,l2_g6, l2_p7,l2_g7;
	wire l3_p0,l3_g0, l3_p1,l3_g1, l3_p2,l3_g2, l3_p3,l3_g3, l3_p4,l3_g4, l3_p5,l3_g5, l3_p6,l3_g6, l3_p7,l3_g7;
	
	preprocess p0(term0[0],term1[0],p[0],g[0]);
	preprocess p1(term0[1],term1[1],p[1],g[1]);
	preprocess p2(term0[2],term1[2],p[2],g[2]);
	preprocess p3(term0[3],term1[3],p[3],g[3]);
	preprocess p4(term0[4],term1[4],p[4],g[4]);
	preprocess p5(term0[5],term1[5],p[5],g[5]);
	preprocess p6(term0[6],term1[6],p[6],g[6]);
	preprocess p7(term0[7],term1[7],p[7],g[7]);
	preprocess p8(term0[8],term1[8],p[8],g[8]);
	preprocess p9(term0[9],term1[9],p[9],g[9]);
	preprocess p10(term0[10],term1[10],p[10],g[10]);
	preprocess p11(term0[11],term1[11],p[11],g[11]);
	preprocess p12(term0[12],term1[12],p[12],g[12]);
	preprocess p13(term0[13],term1[13],p[13],g[13]);
	preprocess p14(term0[14],term1[14],p[14],g[14]);
	
	process l0_pr0(p[0],g[0],1'b0,cin,l0_p0,l0_g0);
	process l0_pr1(p[2],g[2],p[1],g[1],l0_p1,l0_g1);
	process l0_pr2(p[4],g[4],p[3],g[3],l0_p2,l0_g2);
	process l0_pr3(p[6],g[6],p[5],g[5],l0_p3,l0_g3);
	process l0_pr4(p[8],g[8],p[7],g[7],l0_p4,l0_g4);
	process l0_pr5(p[10],g[10],p[9],g[9],l0_p5,l0_g5);
	process l0_pr6(p[12],g[12],p[11],g[11],l0_p6,l0_g6);
	process l0_pr7(p[14],g[14],p[13],g[13],l0_p7,l0_g7);
	
	process l1_pr0(p[1],g[1],l0_p0,l0_g0,l1_p0,l1_g0);
	process l1_pr1(l0_p1,l0_g1,l0_p0,l0_g0,l1_p1,l1_g1);
	process l1_pr2(p[5],g[5],l0_p2,l0_g2,l1_p2,l1_g2);
	process l1_pr3(l0_p3,l0_g3,l0_p2,l0_g2,l1_p3,l1_g3);
	process l1_pr4(p[9],g[9],l0_p4,l0_g4,l1_p4,l1_g4);
	process l1_pr5(l0_p5,l0_g5,l0_p4,l0_g4,l1_p5,l1_g5);
	process l1_pr6(p[13],g[13],l0_p6,l0_g6,l1_p6,l1_g6);
	process l1_pr7(l0_p7,l0_g7,l0_p6,l0_g6,l1_p7,l1_g7);
	
	process l2_pr0(p[3],g[3],l1_p1,l1_g1,l2_p0,l2_g0);
	process l2_pr1(l0_p2,l0_g2,l1_p1,l1_g1,l2_p1,l2_g1);
	process l2_pr2(l1_p2,l1_g2,l1_p1,l1_g1,l2_p2,l2_g2);
	process l2_pr3(l1_p3,l1_g3,l1_p1,l1_g1,l2_p3,l2_g3);
	process l2_pr4(p[11],g[11],l1_p5,l1_g5,l2_p4,l2_g4);
	process l2_pr5(l0_p6,l0_g6,l1_p5,l1_g5,l2_p5,l2_g5);
	process l2_pr6(l1_p6,l1_g6,l1_p5,l1_g5,l2_p6,l2_g6);
	process l2_pr7(l1_p7,l1_g7,l1_p5,l1_g5,l2_p7,l2_g7);
	
	process l3_pr0(p[7],g[7],l2_p3,l2_g3,l3_p0,l3_g0);
	process l3_pr1(l0_p4,l0_g4,l2_p3,l2_g3,l3_p1,l3_g1);
	process l3_pr2(l1_p4,l1_g4,l2_p3,l2_g3,l3_p2,l3_g2);
	process l3_pr3(l1_p5,l1_g5,l2_p3,l2_g3,l3_p3,l3_g3);
	process l3_pr4(l2_p4,l2_g4,l2_p3,l2_g3,l3_p4,l3_g4);
	process l3_pr5(l2_p5,l2_g5,l2_p3,l2_g3,l3_p5,l3_g5);
	process l3_pr6(l2_p6,l2_g6,l2_p3,l2_g3,l3_p6,l3_g6);
	process l3_pr7(l2_p7,l2_g7,l2_p3,l2_g3,l3_p7,l3_g7);
	
	add a0(term0[0],term1[0],cin,sum[0]);
	add a1(term0[1],term1[1],l0_g0,sum[1]);
	add a2(term0[2],term1[2],l1_g0,sum[2]);
	add a3(term0[3],term1[3],l1_g1,sum[3]);
	add a4(term0[4],term1[4],l2_g0,sum[4]);
	add a5(term0[5],term1[5],l2_g1,sum[5]);
	add a6(term0[6],term1[6],l2_g2,sum[6]);
	add a7(term0[7],term1[7],l2_g3,sum[7]);
	add a8(term0[8],term1[8],l3_g0,sum[8]);
	add a9(term0[9],term1[9],l3_g1,sum[9]);
	add a10(term0[10],term1[10],l3_g2,sum[10]);
	add a11(term0[11],term1[11],l3_g3,sum[11]);
	add a12(term0[12],term1[12],l3_g4,sum[12]);
	add a13(term0[13],term1[13],l3_g5,sum[13]);
	add a14(term0[14],term1[14],l3_g6,sum[14]);
	add a15(term0[15],term1[15],l3_g7,sum[15]);

	assign cout = term0[15]&l3_g7 | term1[15]&l3_g7 | term0[15]&term1[15];
endmodule
	 
	

