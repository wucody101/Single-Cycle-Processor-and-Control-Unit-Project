`define AND   4'b0000
`define OR    4'b0001
`define ADD   4'b0010
`define SUB   4'b0110
`define PassB 4'b0111


module ALU(BusW, BusA, BusB, ALUCtrl, Zero);
    //oututs and inputs
    output  [63:0] BusW;
    input   [63:0] BusA, BusB;
    input   [3:0] ALUCtrl;
    output reg  Zero;
    //wire
    reg     [63:0] BusW;
    //always case to change if ctrl or any bus changes
    always @(ALUCtrl or BusA or BusB) begin
        case(ALUCtrl) 
            `AND: begin //AND
                BusW = BusA & BusB;
		 Zero = (BusW == 64'b0 ? 1'b1 : 1'b0);
            end
            
	    `OR: begin //OR
                BusW = BusA | BusB;
		 Zero = (BusW == 64'b0 ? 1'b1 : 1'b0);
            end
            
            `ADD: begin //ADD
                BusW = BusA + BusB;
		 Zero = (BusW == 64'b0 ? 1'b1 : 1'b0);
            end
            
	    `SUB: begin //SUB
                BusW = BusA - BusB;
		 Zero = (BusW == 64'b0 ? 1'b1 : 1'b0);
            end

            `PassB: begin //PassB
                BusW = BusB;
		 Zero = (BusW == 64'b0 ? 1'b1 : 1'b0);
            end
	     
        endcase
    end

endmodule
