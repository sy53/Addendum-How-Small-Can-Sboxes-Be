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



module sbox_lblock5(
	input [3:0] sbin,
	output [3:0] sbout
);

wire x0,x1,x2,x3,y0,y1,y2,y3;
wire NOT_0,NOR_1,NOR_2,NOR_3,NAND_4,NOT_5,NOR_6,NOR_7,NOT_8,NAND_9,NOR_10,NOR_11,NOR_12,NAND_13,NOR_14,NOR_15,NOR_16,NOR_17,NOR_18,NOR_19,NOR_20,NOR_21,NAND_22,NOR_23,NOR_24,NOR_25,NAND_26,NAND_27;

assign {x0,x1,x2,x3} = sbin;
assign sbout = {y0,y1,y2,y3};

/*
assign NOT_0 = ~x0;
assign NOR_1 = ~(x1 | x3);
assign NOR_2 = ~(x2 | x3);
assign NOR_3 = ~(x2 | NOT_0);
assign NAND_4 = ~(x2 & x3);
assign NOT_5 = ~NOR_2;
assign NOR_6 = ~(x0 | x1);
assign NOR_7 = ~(x2 | NOT_0);
assign NOT_8 = ~NAND_4;
assign NAND_9 = ~(x2 & NOT_0);
assign NOR_10 = ~(x0 | x3);
assign NOR_11 = ~(NOT_5 | NOR_6);
assign NOR_12 = ~(x3 | NOR_7);
assign NAND_13 = ~(x1 & NAND_9);
assign NOR_14 = ~(x1 | NOR_10);
assign NOR_15 = ~(NOR_2 | NOT_8);
assign NOR_16 = ~(NOR_1 | NOR_6);
assign NOR_17 = ~(NOR_6 | NAND_9);
assign NOR_18 = ~(NAND_4 | NOR_6);
assign NOR_19 = ~(NOR_12 | NOR_17);
assign NOR_20 = ~(NOR_14 | NOR_17);
assign NOR_21 = ~(NOR_3 | NAND_13);
assign NAND_22 = ~(NOR_6 & NOR_15);
assign NOR_23 = ~(NOR_10 | NOR_16);
assign NOR_24 = ~(NOR_11 | NOR_18);
assign NOR_25 = ~(NOR_21 | NOR_23);
assign NAND_26 = ~(NAND_22 & NOR_24);
assign NAND_27 = ~(NOR_19 & NAND_22);
*/

assign NOT_0 = ~x0;
NOR nor_1 (.in1(x1), .in2(x3), .out(NOR_1));
NOR nor_2 (.in1(x2), .in2(x3), .out(NOR_2));
NOR nor_3 (.in1(x2), .in2(NOT_0), .out(NOR_3));
NAND nand_4 (.in1(x2), .in2(x3), .out(NAND_4));
assign NOT_5 = ~NOR_2;
NOR nor_6 (.in1(x0), .in2(x1), .out(NOR_6));
NOR nor_7 (.in1(x2), .in2(NOT_0), .out(NOR_7));
assign NOT_8 = ~NAND_4;
NAND nand_9 (.in1(x2), .in2(NOT_0), .out(NAND_9));
NOR nor_10 (.in1(x0), .in2(x3), .out(NOR_10));
NOR nor_11 (.in1(NOT_5), .in2(NOR_6), .out(NOR_11));
NOR nor_12 (.in1(x3), .in2(NOR_7), .out(NOR_12));
NAND nand_13 (.in1(x1), .in2(NAND_9), .out(NAND_13));
NOR nor_14 (.in1(x1), .in2(NOR_10), .out(NOR_14));
NOR nor_15 (.in1(NOR_2), .in2(NOT_8), .out(NOR_15));
NOR nor_16 (.in1(NOR_1), .in2(NOR_6), .out(NOR_16));
NOR nor_17 (.in1(NOR_6), .in2(NAND_9), .out(NOR_17));
NOR nor_18 (.in1(NAND_4), .in2(NOR_6), .out(NOR_18));
NOR nor_19 (.in1(NOR_12), .in2(NOR_17), .out(NOR_19));
NOR nor_20 (.in1(NOR_14), .in2(NOR_17), .out(NOR_20));
NOR nor_21 (.in1(NOR_3), .in2(NAND_13), .out(NOR_21));
NAND nand_22 (.in1(NOR_6), .in2(NOR_15), .out(NAND_22));
NOR nor_23 (.in1(NOR_10), .in2(NOR_16), .out(NOR_23));
NOR nor_24 (.in1(NOR_11), .in2(NOR_18), .out(NOR_24));
NOR nor_25 (.in1(NOR_21), .in2(NOR_23), .out(NOR_25));
NAND nand_26 (.in1(NAND_22), .in2(NOR_24), .out(NAND_26));
NAND nand_27 (.in1(NOR_19), .in2(NAND_22), .out(NAND_27));

assign y0 = NAND_27;
assign y1 = NOR_20;
assign y2 = NOR_25;
assign y3 = NAND_26;

endmodule
