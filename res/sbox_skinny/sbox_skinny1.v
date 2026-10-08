module OR(
	input in1,
	input in2,
	output out
);
assign out = in1 | in2;
endmodule

module MOAI(	
	input in1,
	input in2,
	input in3,
	input in4,
	output out
);
assign out = ~((in1 | in2) & (~(in3 & in4)));
endmodule



module sbox_skinny1(
	input [3:0] sbin,
	output [3:0] sbout
);     
	wire x0,x1,x2,x3,y0,y1,y2,y3;	
	wire n9,n11,n13,n15;

	assign {x0,x1,x2,x3}=sbin;
	assign sbout={y0,y1,y2,y3};

	/*
	assign n9 = x0 | x1;
	assign y0 = ~((x3 | n9) & (~(x3 & n9)));
	assign n11 = x1 | x2;
	assign y1 = ~((x0 | n11) & (~(x0 & n11)));
	assign n13 = x2 | y0;
	assign y2 = ~((x1 | n13) & (~(x1 & n13)));
	assign n15 = y0 | y1;
	assign y3 = ~((x2 | n15) & (~(x2 & n15)));
	*/

	OR or_0 (.in1(x0), .in2(x1), .out(n9));
	MOAI moai_1 (.in1(x3), .in2(n9), .in3(x3), .in4(n9), .out(y0));
	OR or_2 (.in1(x1), .in2(x2), .out(n11));
	MOAI moai_3 (.in1(x0), .in2(n11), .in3(x0), .in4(n11), .out(y1));
	OR or_4 (.in1(x2), .in2(y0), .out(n13));
	MOAI moai_5 (.in1(x1), .in2(n13), .in3(x1), .in4(n13), .out(y2));
	OR or_6 (.in1(y0), .in2(y1), .out(n15));
	MOAI moai_7 (.in1(x2), .in2(n15), .in3(x2), .in4(n15), .out(y3));

endmodule

