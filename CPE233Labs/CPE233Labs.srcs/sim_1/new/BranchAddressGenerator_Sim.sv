`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Nathan Jaggers
// 
// Create Date: 02/03/2021 03:31:01 PM 
//////////////////////////////////////////////////////////////////////////////////


module BranchAddressGenerator_Sim();

    logic  [31:0] PC;
    logic  [31:0] Jtype;
    logic  [31:0] Btype;
    logic  [31:0] Itype;
    logic  [31:0] register;
    logic [31:0] jal;
    logic [31:0] branch;
    logic [31:0] jalr;

BranchAddressGenerator BAG_Sim(.*);

//test cases

initial begin
   
   PC = 0; Jtype = 0; Btype = 0; Itype = 0; register = 0;
   #5;
   PC = 1; Jtype = 1; Btype = 2; Itype = 3; register = 4;
   #5;
   PC = 32'h2000; Jtype = 32'h80010345; Btype = 32'h80030100; Itype = 32'h87650000; register = 32'h4000;
   #5; 

end

endmodule
