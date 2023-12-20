`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Nathan Jaggers
// 
// Create Date: 01/15/2021 12:33:37 PM
// Description: 
//////////////////////////////////////////////////////////////////////////////////


module ProgramCounter(
    input PC_CLK,
    input PC_WRITE,
    input PC_RESET,
    input  [31:0] PC_DIN,
    output logic[31:0] PC_COUNT
    );
    
    always_ff @(posedge PC_CLK)
    begin
        if(PC_RESET)        //if reset is high, set reset address to 32-bit zer0
        begin
        PC_COUNT <= 32'b0; 
        end
        
        else if (PC_WRITE)  //if write is high, set address to din
        begin
        PC_COUNT <= PC_DIN;
        end

    end
endmodule
