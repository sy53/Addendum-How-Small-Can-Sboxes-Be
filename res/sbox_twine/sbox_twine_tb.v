`timescale  1ns/1ns


module sbox_twine_tb();

reg clk;
reg [3:0] sbin;
wire [3:0] sbout1;
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


sbox_twine1 u1(
.sbin(sbin),
.sbout(sbout1)

);

sbox_twine5 u5(
.sbin(sbin),
.sbout(sbout5)

);


endmodule