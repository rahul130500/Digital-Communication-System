module t_task3;
  
  reg [95:0] a;
  reg [47:0] inp;
  
  reg clk,inpv,ld,ou,start,done;
  task3 x1(inpv,clk,start,a,done);
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

  shift_reg s1(inp,clk,start,inpv);
  initial
    inp=48'h03_01_02_03_30_3A;
  initial
 begin
   $monitor ($time, " %h %b %b", a, inpv,done);
   $dumpfile ("mul.vcd"); $dumpvars (0, t_task3);
 end
  initial #1100 $finish;
endmodule
