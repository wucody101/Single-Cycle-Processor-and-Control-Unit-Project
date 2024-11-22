module NextPClogic(NextPC, CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch); 
   input [63:0] CurrentPC, SignExtImm64; 
   input 	Branch, ALUZero, Uncondbranch; 
   output reg [63:0] NextPC; 

    always @(*) begin

//Check Conditionals, CBZ if Zero is true 

     if (Branch && ALUZero) begin 
	     NextPC = CurrentPC + (SignExtImm64 << 2);   //Add branch offset to PC
     end

//Check unconditional branch for B 

    else if (Uncondbranch) begin
            NextPC = CurrentPC + (SignExtImm64 << 2);   
        end

//D, R, or non-branching will just increment PC+4


//R or non-branching

      else begin
            NextPC = CurrentPC + 4;
        end
    end

endmodule


