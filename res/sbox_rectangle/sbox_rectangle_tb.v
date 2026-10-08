`timescale  1ns/1ns


module sbox_rectangle_tb();

reg clk;
reg [3:0] sbin;
wire [3:0] sbout1;
wire [3:0] sbout2;
wire [3:0] sbout3;
wire [3:0] sbout4;
wire [3:0] sbout5;




integer i;


initial begin 

	clk <= 0;
	sbin <= 4'd0;

	#1

	for(i=0;i<16;i=i+1) begin
		sbin <= i;
		#1 clk <= ~clk;
		#1 clk <= ~clk;


	end

end


sbox_rectangle1 u1(
.sbin(sbin),
.sbout(sbout1)

);

sbox_rectangle2 u2(
.sbin(sbin),
.sbout(sbout2)

);

sbox_rectangle3 u3(
.sbin(sbin),
.sbout(sbout3)

);

sbox_rectangle4 u4(
.sbin(sbin),
.sbout(sbout4)

);

sbox_rectangle5 u5(
.sbin(sbin),
.sbout(sbout5)

);

endmodule