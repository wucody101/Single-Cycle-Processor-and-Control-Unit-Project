module SignExtender(BusImm, Imm26, Ctrl); 
   output reg [63:0] BusImm; 
   input [25:0]  Imm26; 
   input [2:0]	 Ctrl; 
   
   reg 	 extBit;

   always @(*) begin
      case (Ctrl)
         3'b000: begin //I type represented as 000
	    extBit = Imm26[21]; //21:10 immediate
            BusImm = {{52'b0}, Imm26[21:10]}; //unsigned extended
         end
         
         3'b001: begin //D type represented as 001
	    extBit = Imm26[20]; //20:12 immediate
            BusImm = {{55{extBit}}, Imm26[20:12]}; //signed extended
         end
         
         3'b010: begin //CBZ type represented as 010
            extBit = Imm26[23]; //23:5 immediate
            BusImm = {{45{extBit}}, Imm26[23:5]};//signed extended
         end
         
         3'b011: begin //B typerepresented as 011
            extBit = Imm26[25]; //25:0 immediate
            BusImm = {{38{extBit}}, Imm26}; //signed extended
         end
	 3'b100: begin //MOVZ represented as 100
	    case (Imm26[22:21])	
		//Do each case to add to opcode to know which to LSL to zero extend            
	        2'b00: begin // LSL 0
                    extBit = Imm26[16]; //5:20 immediate
                    BusImm = {{48'b0}, Imm26[20:5]}; //zero extended
                    $display("%x\n", BusImm);
                end
	        2'b01: begin // LSL 16
                    extBit = Imm26[16]; //5:20 immediate
                    BusImm = {{32'b0}, Imm26[20:5], {16'b0}}; //zero extended
                    $display("%x\n", BusImm);
                end
	        2'b10: begin // LSL 32
                    extBit = Imm26[16]; //5:20 immediate
                    BusImm = {{16'b0}, Imm26[20:5], {32'b0}}; //zero extended
                    $display("%x\n", BusImm);
                end
	        2'b11: begin // LSL 48
                    extBit = Imm26[16]; //5:20 immediate
                    BusImm = {Imm26[20:5], {48'b0}}; //zero extended
                    $display("%x\n", BusImm);
                end
             endcase
         end
      endcase
   end
   
endmodule
