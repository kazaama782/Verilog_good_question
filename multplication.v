// Code your design here




module main(eqz,lda,ldb,ldp,clrp,decb,clk,din);
  input lda,ldb,ldp,clrp,decb,clk;
  input [15:0]din;
  output eqz;
  wire [15:0]x,y,z,bout,bus;
  
  pipo1 a(x,lda,bus,clk);
  pipo2 p(y,ldb,clrp,z,clk);
  cntr b(bout,bus,ldb,decb,clk);
  add ad(z,x,y);
  cmp zero(eqz,bout);
  
endmodule

module pipo1(out,ld,din,clk);
  input clk,ld;
  input [15:0]din;
  output reg [15:0]out;
  
  always @(posedge clk)
    if(ld)
      out<=din;
endmodule

module pipo2(out,ld,clr,din,clk);
  input ld,clr,clk;
  input [15:0]din;
  output reg[15:0]out;
  
  always @(posedge clk)
    begin
      if(clr)
        out<=16'b0;
      else if(ld)
        out<=din;
    end
endmodule

module cmp(eqz,din);
  input [15:0]din;
  output eqz;
  
  assign eqz = (din==0);
endmodule


module add(out,in1,in2);
  input [15:0]in1,in2;
  output reg[15:0]out;
  
  always @(*)
    out=in1 + in2;
endmodule

module cntr(out,din,ld,dec,clk);
  input [15:0]din;
  input ld,dec,clk;
  output reg [15:0]out;
  
  always @(posedge clk)
    if(ld)
      out<=din;
  else if(dec)
    out<=out-1;
endmodule

module     control_path(done,lda,ldb,ldp,clrp,decb,eqz,start,din,clk);
 
  input [15:0]din;
  input clk,start,eqz;
  output reg lda,ldb,ldp,clrp,decb,done;
  reg [2:0]state;
  parameter s0=3'b000,s1=3'b001,s2=3'b010,s3=3'b011,s4=3'b100;
  
always @(posedge clk)
  case(state)
    s0: if (start) state <= s1;
    s1: state <= s2;
    s2: state <= s3;
    s3: if (eqz)
          state <= s4;
        else
          state <= s3;
    s4: state <= s4;
    default: state <= s0;
  endcase

  
  always @(state)
    begin
      case(state)
        s0:begin
          #1 lda=0;ldb=0;ldp=0;clrp=0;decb=0;
        end
        s1:begin
          #1 lda=1;
        end
        s2: begin
          #1 lda=0;ldb=1;clrp=1;
        end
        s3:begin
          #1 lda=0;ldb=0;decb=1;clrp=0;
        end
        s4:begin
          #1 lda=0;ldb=0;decb=0;clrp=0;done=1;
        end
          default:begin
          #1 lda=0;ldb=0;ldp=0;clrp=0;decb=0;
        end
      endcase
    end
endmodule

  




Testbench:-



module tb_multiplier;

  reg clk;
  reg start;
  reg [15:0] din;
wire done;
    wire eqz;
  wire lda;
  wire ldb;
  wire ldp;
  wire clrp;
  wire decb;
  
  main uut(eqz,lda,ldb,ldp,clrp,decb,clk,din);
  control_path dut(done,lda,ldb,ldp,clrp,decb,eqz,start,din,clk);

  initial
    begin
      clk=0;
      #3 start=1;
      #500 $finish;
    end
  
  always #5 clk=~clk;
  
  initial
    begin
      #17 din=17;
      #10 din=5;
    end
  initial
    begin
      $monitor($time,"%d %b",uut.y,done);
      $dumpfile("main.vcd");
      $dumpvars(0,tb_multiplier);
    end
endmodule
    