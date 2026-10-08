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

module sbox_twine5(
	input [3:0] sbin,
	output [3:0] sbout
);

wire x0,x1,x2,x3,y0,y1,y2,y3;
wire NOT_0,NOT_1,NOT_2,NAND_3,NOT_4,NAND_5,NAND_6,NAND_7,NOR_8,NAND_9,NOR_10,NAND_11,NOR_12,NOR_13,NOT_14,NOR_15,NOT_16,NAND_17,NOT_18,NAND_19,NAND_20,NOR_21,NAND_22,NOR_23,NOR_24,NAND_25,NOR_26,NAND_27,NOR_28,NOR_29,NAND_30,NAND_31,NOR_32,NOR_33,NOR_34,NAND_35,NOR_36,NAND_37,NOR_38,NOR_39,NAND_40;

assign {x0,x1,x2,x3} = sbin;
assign sbout = {y0,y1,y2,y3};

assign NOT_0 = ~x0;
assign NOT_1 = ~x2;
assign NOT_2 = ~x3;
NAND nand_3 (.in1(x1), .in2(x2), .out(NAND_3));
assign NOT_4 = ~NAND_3;
NAND nand_5 (.in1(x0), .in2(x2), .out(NAND_5));
NAND nand_6 (.in1(x0), .in2(x1), .out(NAND_6));
NAND nand_7 (.in1(NOT_0), .in2(NOT_1), .out(NAND_7));
NOR nor_8 (.in1(x2), .in2(x3), .out(NOR_8));
NAND nand_9 (.in1(x2), .in2(NOT_2), .out(NAND_9));
NOR nor_10 (.in1(x2), .in2(NOT_2), .out(NOR_10));
NAND nand_11 (.in1(x0), .in2(NOT_2), .out(NAND_11));
NOR nor_12 (.in1(x0), .in2(x1), .out(NOR_12));
NOR nor_13 (.in1(x1), .in2(x2), .out(NOR_13));
assign NOT_14 = ~NAND_5;
NOR nor_15 (.in1(x1), .in2(x3), .out(NOR_15));
assign NOT_16 = ~NAND_11;
NAND nand_17 (.in1(x2), .in2(NOT_2), .out(NAND_17));
assign NOT_18 = ~NAND_6;
NAND nand_19 (.in1(x1), .in2(x3), .out(NAND_19));
NAND nand_20 (.in1(NAND_5), .in2(NAND_19), .out(NAND_20));
NOR nor_21 (.in1(NAND_6), .in2(NAND_9), .out(NOR_21));
NAND nand_22 (.in1(NOR_12), .in2(NAND_17), .out(NAND_22));
NOR nor_23 (.in1(NOR_8), .in2(NOT_18), .out(NOR_23));
NOR nor_24 (.in1(NOT_4), .in2(NOT_16), .out(NOR_24));
NAND nand_25 (.in1(NOT_2), .in2(NOR_12), .out(NAND_25));
NOR nor_26 (.in1(NOR_13), .in2(NOT_14), .out(NOR_26));
NAND nand_27 (.in1(x1), .in2(NAND_17), .out(NAND_27));
NOR nor_28 (.in1(x2), .in2(NAND_6), .out(NOR_28));
NOR nor_29 (.in1(x3), .in2(NOR_13), .out(NOR_29));
NAND nand_30 (.in1(NAND_7), .in2(NAND_20), .out(NAND_30));
NAND nand_31 (.in1(NAND_22), .in2(NOR_23), .out(NAND_31));
NOR nor_32 (.in1(NAND_22), .in2(NOR_26), .out(NOR_32));
NOR nor_33 (.in1(NOR_10), .in2(NAND_27), .out(NOR_33));
NOR nor_34 (.in1(NOR_15), .in2(NOR_26), .out(NOR_34));
NAND nand_35 (.in1(NOR_28), .in2(NOR_29), .out(NAND_35));
NOR nor_36 (.in1(NOR_21), .in2(NOR_24), .out(NOR_36));
NAND nand_37 (.in1(NAND_25), .in2(NAND_30), .out(NAND_37));
NOR nor_38 (.in1(NOR_33), .in2(NOR_34), .out(NOR_38));
NOR nor_39 (.in1(NOR_32), .in2(NOR_36), .out(NOR_39));
NAND nand_40 (.in1(NAND_31), .in2(NAND_35), .out(NAND_40));

assign y0 = NOR_38;
assign y1 = NAND_37;
assign y2 = NOR_39;
assign y3 = NAND_40;

endmodule
