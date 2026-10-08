module NOR(
	input in1,
	input in2,
	output out
);
assign out = ~(in1 | in2);
endmodule

module NAND(
	input in1,
	input in2,
	output out
);
assign out = ~(in1 & in2);
endmodule



module sbox_piccolo5(
	input [3:0] sbin,
	output [3:0] sbout
);

wire x0,x1,x2,x3,y0,y1,y2,y3;
wire NOR_0,NOR_1,NOR_2,NOR_3,NOR_4,NOR_5,NOR_6,NOR_7,NOR_8,NOR_9,NOR_10,NOT_11,NAND_12,NAND_13,NOR_14,NOT_15,NAND_16,NOR_17,NAND_18,NAND_19,NOR_20,NOR_21,NAND_22,NAND_23,NOR_24,NOR_25;

assign {x0,x1,x2,x3} = sbin;
assign sbout = {y0,y1,y2,y3};

/*
assign NOR_0 = ~(x0 | x1);
assign NOR_1 = ~(x0 | x3);
assign NOR_2 = ~(x1 | x2);
assign NOR_3 = ~(x0 | x2);
assign NOR_4 = ~(x2 | x3);
assign NOR_5 = ~(x1 | x3);
assign NOR_6 = ~(x1 | NOR_3);
assign NOR_7 = ~(x3 | NOR_2);
assign NOR_8 = ~(NOR_0 | NOR_3);
assign NOR_9 = ~(x2 | NOR_5);
assign NOR_10 = ~(NOR_0 | NOR_1);
assign NOT_11 = ~NOR_8;
assign NAND_12 = ~(NOR_0 & NOR_3);
assign NAND_13 = ~(x0 & NOR_2);
assign NOR_14 = ~(x3 | NOR_1);
assign NOT_15 = ~NOR_9;
assign NAND_16 = ~(x0 & NAND_13);
assign NOR_17 = ~(NOR_4 | NOR_6);
assign NAND_18 = ~(NOR_10 & NOT_15);
assign NAND_19 = ~(NOR_7 & NOT_11);
assign NOR_20 = ~(NOR_5 | NOR_10);
assign NOR_21 = ~(NOR_9 | NAND_13);
assign NAND_22 = ~(NAND_18 & NAND_19);
assign NAND_23 = ~(NAND_12 & NAND_16);
assign NOR_24 = ~(NOR_17 | NOR_21);
assign NOR_25 = ~(NOR_14 | NOR_20);
*/

NOR nor_0 (.in1(x0), .in2(x1), .out(NOR_0));
NOR nor_1 (.in1(x0), .in2(x3), .out(NOR_1));
NOR nor_2 (.in1(x1), .in2(x2), .out(NOR_2));
NOR nor_3 (.in1(x0), .in2(x2), .out(NOR_3));
NOR nor_4 (.in1(x2), .in2(x3), .out(NOR_4));
NOR nor_5 (.in1(x1), .in2(x3), .out(NOR_5));
NOR nor_6 (.in1(x1), .in2(NOR_3), .out(NOR_6));
NOR nor_7 (.in1(x3), .in2(NOR_2), .out(NOR_7));
NOR nor_8 (.in1(NOR_0), .in2(NOR_3), .out(NOR_8));
NOR nor_9 (.in1(x2), .in2(NOR_5), .out(NOR_9));
NOR nor_10 (.in1(NOR_0), .in2(NOR_1), .out(NOR_10));
assign NOT_11 = ~NOR_8;
NAND nand_12 (.in1(NOR_0), .in2(NOR_3), .out(NAND_12));
NAND nand_13 (.in1(x0), .in2(NOR_2), .out(NAND_13));
NOR nor_14 (.in1(x3), .in2(NOR_1), .out(NOR_14));
assign NOT_15 = ~NOR_9;
NAND nand_16 (.in1(x0), .in2(NAND_13), .out(NAND_16));
NOR nor_17 (.in1(NOR_4), .in2(NOR_6), .out(NOR_17));
NAND nand_18 (.in1(NOR_10), .in2(NOT_15), .out(NAND_18));
NAND nand_19 (.in1(NOR_7), .in2(NOT_11), .out(NAND_19));
NOR nor_20 (.in1(NOR_5), .in2(NOR_10), .out(NOR_20));
NOR nor_21 (.in1(NOR_9), .in2(NAND_13), .out(NOR_21));
NAND nand_22 (.in1(NAND_18), .in2(NAND_19), .out(NAND_22));
NAND nand_23 (.in1(NAND_12), .in2(NAND_16), .out(NAND_23));
NOR nor_24 (.in1(NOR_17), .in2(NOR_21), .out(NOR_24));
NOR nor_25 (.in1(NOR_14), .in2(NOR_20), .out(NOR_25));

assign y0 = NOR_25;
assign y1 = NAND_23;
assign y2 = NOR_24;
assign y3 = NAND_22;

endmodule
