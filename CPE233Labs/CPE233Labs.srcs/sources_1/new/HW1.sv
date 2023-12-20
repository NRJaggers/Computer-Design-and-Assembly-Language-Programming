`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Nathan Jaggers
// 
// Create Date: 01/15/2021 12:33:37 PM
// Description: 
//////////////////////////////////////////////////////////////////////////////////


module HW2(
    input HW2_CLK,               //
    input HW2_WRITE,             //
    input HW2_RESET,             //
    input  [31:0] HW2_JALR,      //
    input  [31:0] HW2_BRANCH,    //
    input  [31:0] HW2_JAL,       //
    input  [31:0] HW2_MTEVC,     //
    input  [31:0] HW2_MEPC,      //
    input  [2:0]  HW2_pcSource,  //mux select
    output [31:0] HW2_ADDRESS    //
    );
    
    //logic
    logic  [31:0] pc_DIN, pc_COUNT, mux_INPUT_PC;
    
    //link decvices and increment count by 4
    ProgramCounter HW2_PC (.PC_CLK(HW2_CLK), .PC_WRITE(HW2_WRITE), .PC_RESET(HW2_RESET), .PC_DIN(pc_DIN), .PC_COUNT(pc_COUNT));
    assign HW2_ADDRESS = pc_COUNT;
    assign mux_INPUT_PC = pc_COUNT + 4; 
    mux HW2_MUX(.MUX_INPUT_PC(mux_INPUT_PC),.MUX_JALR(HW2_JALR),.MUX_BRANCH(HW2_BRANCH),.MUX_JAL(HW2_JAL),.MUX_MTEVC(HW2_MTEVC),.MUX_MEPC(HW2_MEPC),.MUX_pcSource(HW2_pcSource), .MUX_out(pc_DIN));

endmodule
