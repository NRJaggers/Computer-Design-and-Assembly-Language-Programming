`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Nathan Jaggers
// 
// Create Date: 01/28/2021 01:19:36 PM
// Description: 
//////////////////////////////////////////////////////////////////////////////////


module ImmediateGenerator(
    input  [31:0] IG_instruction,
    output logic [31:0] IG_Utype,
    output logic [31:0] IG_Itype,
    output logic [31:0] IG_Stype,
    output logic [31:0] IG_Jtype,
    output logic [31:0] IG_Btype
    );
    
    always_comb begin
    IG_Utype = {IG_instruction[31:12],12'b0};
    IG_Itype = {{21{IG_instruction[31]}},IG_instruction[30:20]};
    IG_Stype = {{21{IG_instruction[31]}},IG_instruction[30:25],IG_instruction[11:7]};
    IG_Btype = {{20{IG_instruction[31]}},IG_instruction[7],IG_instruction[30:25],IG_instruction[11:8],1'b0};
    IG_Jtype = {{12{IG_instruction[31]}},IG_instruction[19:12],IG_instruction[20],IG_instruction[30:21],1'b0};
  
    end
endmodule
