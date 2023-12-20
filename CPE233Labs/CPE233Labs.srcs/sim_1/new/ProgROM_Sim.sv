`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/10/2021 08:14:18 PM
// Design Name: 
// Module Name: ProgROM_Sim
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ProgROM_Sim();
        logic PROG_CLK;
        logic [31:0] PROG_ADDR = 0;
        logic [31:0] INSTRUCT;
        
    ProgROM ProgROM_inst(.*);

//simulate clock and increment
    always
    begin
        PROG_CLK = 0;
        #5;
        PROG_CLK = 1;
        #5;
        PROG_ADDR+=4 ;
    end
    
//       
        
endmodule
