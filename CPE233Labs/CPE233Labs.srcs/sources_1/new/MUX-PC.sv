`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Nathan Jaggers
// 
// Create Date: 01/15/2020 11:50:45 AM
// Description: Multiplexer for input in program counter
//////////////////////////////////////////////////////////////////////////////////

module mux(
    input [31:0] MUX_INPUT_PC,     //input from Program Counter; value for next instruction
    input [31:0] MUX_JALR,      //
    input [31:0] MUX_BRANCH,    //
    input [31:0] MUX_JAL,       //
    input [31:0] MUX_MTEVC,     //
    input [31:0] MUX_MEPC,      //
    input [2:0]  MUX_pcSource,  //mux select
    output logic [31:0] mux_out
    );
    
    always_comb
    begin
        case(MUX_pcSource)
            3'b000: assign mux_out = MUX_INPUT_PC   ;
            3'b001: assign mux_out = MUX_JALR       ;
            3'b010: assign mux_out = MUX_BRANCH     ;
            3'b011: assign mux_out = MUX_JAL        ;
            3'b100: assign mux_out = MUX_MTEVC      ;
            3'b101: assign mux_out = MUX_MEPC       ;
            //need to handel 6 and 7 what should the default case be?
        endcase
    end 
    
endmodule
