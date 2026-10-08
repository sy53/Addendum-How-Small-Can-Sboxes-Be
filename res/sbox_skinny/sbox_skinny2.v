module NOR(
	input in1,
	input in2,
	output out
);
assign out = ~(in1 | in2);
endmodule

module OR(
	input in1,
	input in2,
	output out
);
assign out = in1 | in2;
endmodule

module XNOR(
	input in1,
	input in2,
	output out
);
assign out = ~(in1 ^ in2);
endmodule

module XOR(
	input in1,
	input in2,
	output out
);
assign out = in1 ^ in2;
endmodule



module sbox_skinny2(
	input [3:0] sbin,
	output [3:0] sbout
);
	wire x0,x1,x2,x3,y0,y1,y2,y3;
	wire t0,t1,t2,t3,t4,t5,t6,t7;

	assign {x0,x1,x2,x3} = sbin;
	assign sbout = {y0,y1,y2,y3};

	/*
	assign t0 = ~(x0 | x1);
	assign t1 = x3 ^ t0;
	assign t2 = x2 | t1;
	assign t3 = ~(x1 ^ t2);
	assign t4 = ~(x1 | x2);
	assign t5 = x0 ^ t4;
	assign t6 = ~(t1 | t5);
	assign t7 = x2 ^ t6;
	*/

	NOR nor_0 (.in1(x0), .in2(x1), .out(t0));
	XOR xor_1 (.in1(x3), .in2(t0), .out(t1));
	OR or_2 (.in1(x2), .in2(t1), .out(t2));
	XNOR xnor_3 (.in1(x1), .in2(t2), .out(t3));
	NOR nor_4 (.in1(x1), .in2(x2), .out(t4));
	XOR xor_5 (.in1(x0), .in2(t4), .out(t5));
	NOR nor_6 (.in1(t1), .in2(t5), .out(t6));
	XOR xor_7 (.in1(x2), .in2(t6), .out(t7));

	assign y0 = t1;
	assign y1 = t5;
	assign y2 = t3;
	assign y3 = t7;


endmodule
