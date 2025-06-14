
module comparator(gt,lt,eq,a,b);
  input [3:0]a,b;
  output reg gt,lt,eq;
  reg [3:0]compare;
  reg [4:0]finale;
  always @(*)
    begin
      gt=0;
      lt=0;
      eq=0;
      
          compare = ~(a^b);
      finale = a+compare+1;
      if((a^b)==0)
        eq=1;
      else
      
        begin
    
          if(finale ==b)
        lt=1;
      else 
        gt=1;
        end
    
    end
endmodule
        

  