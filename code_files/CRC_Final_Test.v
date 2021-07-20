module test;
  parameter bits=48;
  reg [15:0] r;
  reg [95:0] r1;
  reg [95:0] int_out;
  reg [bits-1:0] rn;
  integer n;  
  reg clk,inp,ld,ou,start,done1,done2;
  interleave x3(r1, int_out);
  two x1(inp,clk,start,r,done1);
  one x2(inp,clk,start,r1,done2);
  s_reg s1(rn,clk,start,inp);
  initial
 begin
   start=1;
   #19 start=0;
 end
  initial
    begin
 clk = 1'b0;n=6'b0;
      forever #10 clk = ~clk;
  end  

  always@(posedge clk)
    begin rn<={32'h03_01_02_03,r};
      n<=n+1;
      end
    
  initial
 begin
   $monitor ($time, " %h %h %b %b %d",r1,r, done1,done2,n);
   $dumpfile ("mul.vcd"); $dumpvars (0, test);
 end
  initial begin
    @(posedge done2) begin
 #10 $finish;
 end
 end
endmodule
