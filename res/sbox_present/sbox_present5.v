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

module sbox_present5(
	input [3:0] sbin,
	output [3:0] sbout
);

wire x0,x1,x2,x3,y0,y1,y2,y3;
wire NOT_0,NOR_1,NOT_2,NOR_3,NAND_4,NOR_5,NOR_6,NOT_7,NOR_8,NAND_9,NOT_10,NAND_11,NOR_12,NAND_13,NOT_14,NOR_15,NAND_16,NOT_17,NOR_18,NAND_19,NAND_20,NOR_21,NAND_22,NAND_23,NAND_24,NOR_25,NAND_26,NAND_27,NOR_28,NAND_29,NOR_30,NAND_31,NOR_32,NAND_33,NAND_34,NAND_35,NOT_36,NAND_37,NOT_38,NOT_39,NOR_40,NOR_41,NAND_42,NOT_43,NOT_44,NAND_45,NOR_46,NOR_47,NAND_48;

assign {x0,x1,x2,x3} = sbin;
assign sbout = {y0,y1,y2,y3};

assign NOT_0 = ~x1;
NOR nor_1 (.in1(x2), .in2(x3), .out(NOR_1));
assign NOT_2 = ~NOR_1;
NOR nor_3 (.in1(x0), .in2(x2), .out(NOR_3));
NAND nand_4 (.in1(x0), .in2(x3), .out(NAND_4));
NOR nor_5 (.in1(x3), .in2(NOT_0), .out(NOR_5));
NOR nor_6 (.in1(x2), .in2(NOT_0), .out(NOR_6));
assign NOT_7 = ~NOR_3;
NOR nor_8 (.in1(x0), .in2(x3), .out(NOR_8));
NAND nand_9 (.in1(x2), .in2(x3), .out(NAND_9));
assign NOT_10 = ~NAND_4;
NAND nand_11 (.in1(x3), .in2(NOT_0), .out(NAND_11));
NOR nor_12 (.in1(x1), .in2(NOT_0), .out(NOR_12));
NAND nand_13 (.in1(x0), .in2(x1), .out(NAND_13));
assign NOT_14 = ~NAND_11;
NOR nor_15 (.in1(x0), .in2(NOT_0), .out(NOR_15));
NAND nand_16 (.in1(x1), .in2(x3), .out(NAND_16));
assign NOT_17 = ~NOR_15;
NOR nor_18 (.in1(NOR_1), .in2(NOR_8), .out(NOR_18));
NAND nand_19 (.in1(NOT_7), .in2(NAND_13), .out(NAND_19));
NAND nand_20 (.in1(NOR_6), .in2(NOT_10), .out(NAND_20));
NOR nor_21 (.in1(NOR_6), .in2(NOR_8), .out(NOR_21));
NAND nand_22 (.in1(NAND_4), .in2(NAND_16), .out(NAND_22));
NAND nand_23 (.in1(NOT_7), .in2(NOT_17), .out(NAND_23));
NAND nand_24 (.in1(NOR_3), .in2(NOR_5), .out(NAND_24));
NOR nor_25 (.in1(NAND_9), .in2(NAND_11), .out(NOR_25));
NAND nand_26 (.in1(NAND_9), .in2(NOR_15), .out(NAND_26));
NAND nand_27 (.in1(x2), .in2(NOT_14), .out(NAND_27));
NOR nor_28 (.in1(NOR_1), .in2(NOR_12), .out(NOR_28));
NAND nand_29 (.in1(NOT_7), .in2(NAND_13), .out(NAND_29));
NOR nor_30 (.in1(NOR_3), .in2(NOR_6), .out(NOR_30));
NAND nand_31 (.in1(NOT_2), .in2(NAND_13), .out(NAND_31));
NOR nor_32 (.in1(NAND_4), .in2(NOR_25), .out(NOR_32));
NAND nand_33 (.in1(NOR_30), .in2(NAND_31), .out(NAND_33));
NAND nand_34 (.in1(NAND_20), .in2(NAND_24), .out(NAND_34));
NAND nand_35 (.in1(NAND_26), .in2(NAND_27), .out(NAND_35));
assign NOT_36 = ~NAND_33;
NAND nand_37 (.in1(NOR_28), .in2(NAND_29), .out(NAND_37));
assign NOT_38 = ~NAND_37;
assign NOT_39 = ~NOR_32;
NOR nor_40 (.in1(NOR_18), .in2(NAND_23), .out(NOR_40));
NOR nor_41 (.in1(NAND_19), .in2(NAND_22), .out(NOR_41));
NAND nand_42 (.in1(NAND_4), .in2(NOR_21), .out(NAND_42));
assign NOT_43 = ~NOR_41;
assign NOT_44 = ~NAND_34;
NAND nand_45 (.in1(NAND_42), .in2(NOT_44), .out(NAND_45));
NOR nor_46 (.in1(NAND_35), .in2(NOT_36), .out(NOR_46));
NOR nor_47 (.in1(NOT_38), .in2(NOR_40), .out(NOR_47));
NAND nand_48 (.in1(NOT_39), .in2(NOT_43), .out(NAND_48));

assign y0 = NOR_47;
assign y1 = NOR_46;
assign y2 = NAND_48;
assign y3 = NAND_45;

endmodule
