// Code your testbench here
// or browse Examples
module t_xyz;
parameter bs=40;
reg [15:0] r;
reg [bs-1:0] rn;
reg clk,xin,ld,ou,start,done;
xyz x1(xin,clk,start,r,done);
initial
begin
start=1;
#19 start=0;
end
initial
begin
clk = 1'b0;
forever #10 clk = ~clk;
end
s_reg s1(rn,clk,start,xin);//module to convert parallel data to serial data
initial
rn=40'h1_90_10_21_01;
//rn=32'h03_01_02_03;
initial
begin
$monitor ($time, " %h %b %b", r, xin,done);
$dumpfile ("mul.vcd"); $dumpvars (0, t_xyz);
end
initial #840 $finish;
endmodule