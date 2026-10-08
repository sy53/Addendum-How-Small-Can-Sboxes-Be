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



module sbox_skinny5(
	input [3:0] sbin,
	output [3:0] sbout
);

wire x0,x1,x2,x3,y0,y1,y2,y3;
wire NOT_0,NOT_1,NOR_2,NOR_3,NOT_4,NAND_5,NOR_6,NOR_7,NOR_8,NAND_9,NOR_10,NOR_11,NOR_12,NAND_13,NOR_14,NOR_15,NOT_16,NOR_17,NAND_18,NOR_19,NAND_20,NOR_21,NOR_22,NAND_23,NOR_24,NAND_25,NOR_26,NAND_27;

assign {x0,x1,x2,x3} = sbin;
assign sbout = {y0,y1,y2,y3};

/*
assign NOT_0 = ~x2;
assign NOT_1 = ~x3;
assign NOR_2 = ~(x0 | x1);
assign NOR_3 = ~(x1 | x2);
assign NOT_4 = ~NOR_3;
assign NAND_5 = ~(x0 & x2);
assign NOR_6 = ~(x0 | x3);
assign NOR_7 = ~(x3 | NOT_0);
assign NOR_8 = ~(x2 | NOT_1);
assign NAND_9 = ~(NOT_0 & NOT_1);
assign NOR_10 = ~(NOT_4 | NOR_6);
assign NOR_11 = ~(NOT_1 | NOR_2);
assign NOR_12 = ~(x0 | NOR_7);
assign NAND_13 = ~(x1 & NAND_9);
assign NOR_14 = ~(NOR_2 | NOT_4);
assign NOR_15 = ~(x0 | NOR_3);
assign NOT_16 = ~NOR_11;
assign NOR_17 = ~(x3 | NOR_3);
assign NAND_18 = ~(x1 & NAND_5);
assign NOR_19 = ~(NOR_2 | NOR_8);
assign NAND_20 = ~(NOR_6 & NAND_18);
assign NOR_21 = ~(NOR_17 | NOR_19);
assign NOR_22 = ~(NOR_14 | NOR_15);
assign NAND_23 = ~(NOR_10 & NOT_16);
assign NOR_24 = ~(NOR_12 | NAND_18);
assign NAND_25 = ~(NAND_13 & NAND_23);
assign NOR_26 = ~(NOR_21 | NOR_24);
assign NAND_27 = ~(NOT_16 & NAND_20);
*/

assign NOT_0 = ~x2;
assign NOT_1 = ~x3;
NOR nor_2 (.in1(x0), .in2(x1), .out(NOR_2));
NOR nor_3 (.in1(x1), .in2(x2), .out(NOR_3));
assign NOT_4 = ~NOR_3;
NAND nand_5 (.in1(x0), .in2(x2), .out(NAND_5));
NOR nor_6 (.in1(x0), .in2(x3), .out(NOR_6));
NOR nor_7 (.in1(x3), .in2(NOT_0), .out(NOR_7));
NOR nor_8 (.in1(x2), .in2(NOT_1), .out(NOR_8));
NAND nand_9 (.in1(NOT_0), .in2(NOT_1), .out(NAND_9));
NOR nor_10 (.in1(NOT_4), .in2(NOR_6), .out(NOR_10));
NOR nor_11 (.in1(NOT_1), .in2(NOR_2), .out(NOR_11));
NOR nor_12 (.in1(x0), .in2(NOR_7), .out(NOR_12));
NAND nand_13 (.in1(x1), .in2(NAND_9), .out(NAND_13));
NOR nor_14 (.in1(NOR_2), .in2(NOT_4), .out(NOR_14));
NOR nor_15 (.in1(x0), .in2(NOR_3), .out(NOR_15));
assign NOT_16 = ~NOR_11;
NOR nor_17 (.in1(x3), .in2(NOR_3), .out(NOR_17));
NAND nand_18 (.in1(x1), .in2(NAND_5), .out(NAND_18));
NOR nor_19 (.in1(NOR_2), .in2(NOR_8), .out(NOR_19));
NAND nand_20 (.in1(NOR_6), .in2(NAND_18), .out(NAND_20));
NOR nor_21 (.in1(NOR_17), .in2(NOR_19), .out(NOR_21));
NOR nor_22 (.in1(NOR_14), .in2(NOR_15), .out(NOR_22));
NAND nand_23 (.in1(NOR_10), .in2(NOT_16), .out(NAND_23));
NOR nor_24 (.in1(NOR_12), .in2(NAND_18), .out(NOR_24));
NAND nand_25 (.in1(NAND_13), .in2(NAND_23), .out(NAND_25));
NOR nor_26 (.in1(NOR_21), .in2(NOR_24), .out(NOR_26));
NAND nand_27 (.in1(NOT_16), .in2(NAND_20), .out(NAND_27));

assign y0 = NAND_27;
assign y1 = NOR_22;
assign y2 = NAND_25;
assign y3 = NOR_26;

endmodule
