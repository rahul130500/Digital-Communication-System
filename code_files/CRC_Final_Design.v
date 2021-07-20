module one(input inp,clk,ld, output [95:0] out, output done);
  reg [95:0] out;
  reg done;
  reg [3:0] x;
  reg p1,p0;
  integer i;
  always@(posedge clk)
    begin
     #7 if(ld)
        begin
          x<=4'd0;
          i=-1;
          done=0;
          out=96'd0;
        end
      else if(i<=47)
        begin
          p0<=x[1]+x[2]+x[3]+x[0];
          p1<=x[1]+x[3]+x[0];
          if(i>=0)
            out[((47-i)*2)+:2]<={p1,p0};
          i<=i+1;
          x<={inp,x[3:1]};
        end
      else 
        done=1;
    end
endmodule
          
module two(input x16,clk,ld ,output [15:0] r,output done);  
  parameter bits=32;  
  	reg [15:0] r;  
  reg r15,r2,r0;  
  reg done;  
  integer i; 
  assign r15=r[14]+r[15]+x16; 
  assign r2=r[1]+r[15]+x16;  
  assign r0=r[15]+x16;  
  always@(posedge clk)    
  begin
   #5 if(ld)
      begin 
        r[15:0]<=16'hFFFF;
        i=0;done=1'b0;
      end 
    else  
      begin  
        if(i<bits) 
          begin
            r[15:0]<={r15,r[13:2],r2,r[0],r0}; 
            i<=i+1; 
          end   
        else begin r<=r;done=1'b1;
        end 
      end
  end
endmodule

module interleave (input [95:0] out, output [95:0] int_out);
  bfinterleaver a(out[7:0] , out[15:8] , out[23:16] , out[31:24] ,
                 int_out[7:0] ,
    int_out[15:8] ,	
 int_out[23:16] ,
    int_out[31:24] );
   bfinterleaver b(
      out[39:32] ,
      out[47:40] ,
      out[55:48] ,
      out[63:56] , 	
     int_out[39:32], int_out[47:40], int_out[55:48],int_out[63:56] );
   bfinterleaver c(
     out[71:64], out[79:72],out[87:80], out[95:88],int_out[71:64],int_out[79:72],int_out[87:80],int_out[95:88]);
   endmodule

module bfinterleaver(
input [7:0] byte0,
input [7:0] byte1,
input [7:0] byte2,
input [7:0] byte3, 
output [7:0] out0,
output [7:0] out1,
output [7:0] out2,
output [7:0] out3
);
  assign out0[7] =byte3[1];
  assign out0[6] =byte3[0];
  assign out0[5] =byte2[1];
  assign out0[4] =byte2[0];
  assign out0[3] =byte1[1];
  assign out0[2] =byte1[0];
  assign out0[1] =byte0[1];
  assign out0[0] =byte0[0];
  
  assign out1[7] =byte3[3];
  assign out1[6] =byte3[2];
  assign out1[5] =byte2[3];
  assign out1[4] =byte2[2];
  assign out1[3] =byte1[3];
  assign out1[2] =byte1[2];
  assign out1[1] =byte0[3];
  assign out1[0] =byte0[2];
  
  assign out2[7] =byte3[5];
  assign out2[6] =byte3[4];
  assign out2[5] =byte2[5];
  assign out2[4] =byte2[4];
  assign out2[3] =byte1[5];
  assign out2[2] =byte1[4];
  assign out2[1] =byte0[5];
  assign out2[0] =byte0[4];
  
  assign out3[7] =byte3[7];
  assign out3[6] =byte3[6];
  assign out3[5] =byte2[7];
  assign out3[4] =byte2[6];
  assign out3[3] =byte1[7];
  assign out3[2] =byte1[6];
  assign out3[1] =byte0[7];
  assign out3[0] =byte0[6];

endmodule




module s_reg #(parameter bits=48)(input [bits-1:0] rn,input clk,start,output ou);
  integer i;
  reg ou;
  
  always@(posedge clk )
    begin
      #5if(start)
        begin i=0;ou<=rn[bits-1]; end
        
      else if(i<(bits-1))
        begin
          ou<=rn[bits-2-i];
          i<=i+1;
        end     
    end
endmodule  
