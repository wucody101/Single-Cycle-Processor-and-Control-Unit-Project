module RegisterFile(BusA, BusB, BusW, RA, RB, RW, RegWr, Clk);
    output [63:0] BusA;
    output [63:0] BusB;
    input [63:0] BusW;
    input [4:0] RA, RB, RW;
    input RegWr;
    input Clk;
    reg [63:0] registers [31:0];
    
    // if RA or RB equals 31, then assign to 0
    assign #2 BusA = RA == 5'd31 ? 64'b0 : registers[RA];
    assign #2 BusB = RB == 5'd31 ? 64'b0 : registers[RB];
    
    always @ (negedge Clk) begin
        if(RegWr && RW != 5'd31) //can't change Register 31, BusW stored in register specified by RW
            registers[RW] <= #3 BusW;
    end
        
endmodule
