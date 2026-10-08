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

module sbox_rectangle5(
	input [3:0] sbin,
	output [3:0] sbout
);

wire x0,x1,x2,x3,y0,y1,y2,y3;
wire NOT_0,NOT_1,NAND_2,NAND_3,NOR_4,NOR_5,NAND_6,NAND_7,NAND_8,NOR_9,NAND_10,NOT_11,NOT_12,NOR_13,NOR_14,NOT_15,NOR_16,NAND_17,NOT_18,NOT_19,NAND_20,NOR_21,NOT_22,NOR_23,NAND_24,NAND_25,NAND_26,NAND_27,NAND_28,NAND_29,NOR_30,NOR_31,NOR_32,NOR_33,NOR_34,NOT_35,NOR_36,NAND_37,NOT_38,NOT_39,NAND_40,NOR_41,NAND_42,NOR_43,NOR_44,NAND_45,NAND_46,NAND_47,NOT_48,NAND_49,NOR_50,NOR_51,NOT_52;

assign {x0,x1,x2,x3} = sbin;
assign sbout = {y0,y1,y2,y3};

assign NOT_0 = ~x1;
assign NOT_1 = ~x2;
NAND nand_2 (.in1(x3), .in2(NOT_0), .out(NAND_2));
NAND nand_3 (.in1(x3), .in2(NOT_0), .out(NAND_3));
NOR nor_4 (.in1(x0), .in2(x1), .out(NOR_4));
NOR nor_5 (.in1(x3), .in2(NOT_0), .out(NOR_5));
NAND nand_6 (.in1(x3), .in2(NOT_1), .out(NAND_6));
NAND nand_7 (.in1(x1), .in2(x2), .out(NAND_7));
NAND nand_8 (.in1(x0), .in2(NOT_0), .out(NAND_8));
NOR nor_9 (.in1(x0), .in2(x2), .out(NOR_9));
NAND nand_10 (.in1(x2), .in2(x3), .out(NAND_10));
assign NOT_11 = ~NOT_1;
assign NOT_12 = ~NAND_8;
NOR nor_13 (.in1(x0), .in2(x3), .out(NOR_13));
NOR nor_14 (.in1(x3), .in2(NOT_0), .out(NOR_14));
assign NOT_15 = ~NOT_1;
NOR nor_16 (.in1(x0), .in2(NOT_0), .out(NOR_16));
NAND nand_17 (.in1(x3), .in2(NOT_1), .out(NAND_17));
assign NOT_18 = ~NOR_9;
assign NOT_19 = ~NOR_5;
NAND nand_20 (.in1(x3), .in2(NOT_0), .out(NAND_20));
NOR nor_21 (.in1(x0), .in2(x2), .out(NOR_21));
assign NOT_22 = ~NOR_13;
NOR nor_23 (.in1(NOR_4), .in2(NAND_6), .out(NOR_23));
NAND nand_24 (.in1(NAND_8), .in2(NOT_18), .out(NAND_24));
NAND nand_25 (.in1(NAND_8), .in2(NAND_10), .out(NAND_25));
NAND nand_26 (.in1(NAND_2), .in2(NOT_22), .out(NAND_26));
NAND nand_27 (.in1(NOT_11), .in2(NOT_19), .out(NAND_27));
NAND nand_28 (.in1(NAND_7), .in2(NOR_14), .out(NAND_28));
NAND nand_29 (.in1(x0), .in2(NAND_3), .out(NAND_29));
NOR nor_30 (.in1(NAND_8), .in2(NAND_10), .out(NOR_30));
NOR nor_31 (.in1(NOR_13), .in2(NOT_15), .out(NOR_31));
NOR nor_32 (.in1(NOT_12), .in2(NOR_16), .out(NOR_32));
NOR nor_33 (.in1(NOT_1), .in2(NOR_5), .out(NOR_33));
NOR nor_34 (.in1(NOR_13), .in2(NOR_16), .out(NOR_34));
assign NOT_35 = ~NAND_26;
NOR nor_36 (.in1(x0), .in2(NOR_21), .out(NOR_36));
NAND nand_37 (.in1(NOT_19), .in2(NAND_20), .out(NAND_37));
assign NOT_38 = ~NAND_28;
assign NOT_39 = ~NAND_37;
NAND nand_40 (.in1(NOR_23), .in2(NAND_24), .out(NAND_40));
NOR nor_41 (.in1(NAND_25), .in2(NOT_38), .out(NOR_41));
NAND nand_42 (.in1(NOR_31), .in2(NOT_35), .out(NAND_42));
NOR nor_43 (.in1(NAND_27), .in2(NOR_34), .out(NOR_43));
NOR nor_44 (.in1(NOR_36), .in2(NOT_39), .out(NOR_44));
NAND nand_45 (.in1(NAND_29), .in2(NOR_33), .out(NAND_45));
NAND nand_46 (.in1(NAND_17), .in2(NOR_32), .out(NAND_46));
NAND nand_47 (.in1(NAND_40), .in2(NAND_46), .out(NAND_47));
assign NOT_48 = ~NAND_47;
NAND nand_49 (.in1(NAND_42), .in2(NAND_45), .out(NAND_49));
NOR nor_50 (.in1(NOR_30), .in2(NOR_41), .out(NOR_50));
NOR nor_51 (.in1(NOR_43), .in2(NOR_44), .out(NOR_51));
assign NOT_52 = ~NOR_50;

assign y0 = NAND_49;
assign y1 = NOT_52;
assign y2 = NOR_51;
assign y3 = NOT_48;

endmodule
