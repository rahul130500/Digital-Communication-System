module task3(input inpv,clk,ld, output [95:0] fec, output done);
  reg [95:0] fec;
  reg done;
  reg [3:0] x;
  reg p1,p0;
  integer i;
  always@(posedge clk)
    begin
      if(ld)
        begin
          x<=4'd0;
          i=-1;
          done=0;
          fec=96'd0;
        end
      else if(i<=47)
        begin
          p0<=x[1]+x[2]+x[3]+x[0];
          p1<=x[1]+x[3]+x[0];
          if(i>=0)
            fec[((47-i)*2)+:2]<={p1,p0};
          i<=i+1;
          x<={inpv,x[3:1]};
        end
      else 
        done=1;
    end
endmodule
          
          
module shift_reg #(parameter bits=48)(input [bits-1:0] inp,input clk,start,output ou);
  integer i;
  reg ou;
  
  always@(negedge clk )
    begin
      if(start)
        begin i=0;ou<=inp[bits-1]; end
        
      else if(i<(bits-1))
        begin
          ou<=inp[bits-2-i];
          i<=i+1;
        end     
    end
endmodule 
