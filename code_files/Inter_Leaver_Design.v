
// Code your design here
module xyz(input x16,clk,ld ,output [15:0] r,output done);
parameter bs=40;
reg [15:0] r;
reg r15,r2,r0;
reg done;
integer i;
assign r15=r[14]+r[15]+x16;
assign r2=r[1]+r[15]+x16;
assign r0=r[15]+x16;
always@(posedge clk)
begin
if(ld)
begin r[15:0]<=16'hFFFF;
i=0;done=1'b0;end
else
begin
if(i<bs)
begin
r[15:0]<={r15,r[13:2],r2,r[0],r0};
i<=i+1;
end
else begin r<=r;done=1'b1;end
end
end
endmodule
module s_reg #(parameter bs=40)(input [bs:0] rn,input clk,start,output ou);//module for
converting parallel data to serial data as a shift register
integer i;
reg ou;
always@(posedge clk )
begin
if(start)
begin i=0;ou<=rn[bs-1]; end
else if(i<(bs-1))
begin
ou<=rn[bs-2-i];
i<=i+1;end
end
endmodule