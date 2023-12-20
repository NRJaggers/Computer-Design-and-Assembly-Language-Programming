`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Nathan Jaggers

// Create Date: 01/15/2021 06:59:59 PM
//////////////////////////////////////////////////////////////////////////////////



module MUX_PC_Sim();

    //define signals 
    logic [31:0] MUX_INPUT_PC;  //input from Program Counter; value for next instruction
    logic [31:0] MUX_JALR;      //
    logic [31:0] MUX_BRANCH;    //
    logic [31:0] MUX_JAL;       //
    logic [31:0] MUX_MTEVC;     //
    logic [31:0] MUX_MEPC;      //
    logic [2:0]  MUX_pcSource;  //mux select
    logic [31:0] MUX_out; 
    
    //link signals to module
    mux mux_pc(.*);
    
    //set up test cases
    initial
    begin
        MUX_INPUT_PC = 8'h00000011;
        MUX_JALR = 8'h00000022;
        MUX_BRANCH = 8'h00000033;
        MUX_JAL = 8'h00000044;
        MUX_MTEVC = 8'h00000055;
        MUX_MEPC = 8'h00000066;
        
        MUX_pcSource = 3'b000;
        #5;
        MUX_pcSource = 3'b001;
        #5;
        MUX_pcSource = 3'b010;
        #5;
        MUX_pcSource = 3'b011;
        #5;
        MUX_pcSource = 3'b100;
        #5;
        MUX_pcSource = 3'b101;
        #5;
        MUX_pcSource = 3'b110;
        #5;
        MUX_pcSource = 3'b111;
        #5;
        
    end
    
endmodule
