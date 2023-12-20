`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Nathan Jaggers

// Create Date: 01/15/2021 06:59:59 PM
//////////////////////////////////////////////////////////////////////////////////



module HW2_Sim();

    //define signals 
    logic HW2_CLK;               //
    logic HW2_WRITE;             //
    logic HW2_RESET;             //
    logic  [31:0] HW2_JALR;      //
    logic  [31:0] HW2_BRANCH;    //
    logic  [31:0] HW2_JAL;       //
    logic  [31:0] HW2_MTEVC;     //
    logic  [31:0] HW2_MEPC;      //
    logic  [2:0]  HW2_pcSource;  //mux select
    logic [31:0] HW2_ADDRESS;    // 
    
    //link signals to module
    HW2 hw2(.*);
    
    //set up test cases
    always
    begin
        HW2_CLK = 0;
        #5;
        HW2_CLK = 1;
        #5;           
    end
    
    initial
    begin
        HW2_JALR = 8'h00000022;
        HW2_BRANCH = 8'h00000033;
        HW2_JAL = 8'h00000044;
        HW2_MTEVC = 8'h00000055;
        HW2_MEPC = 8'h00000066;
        
        HW2_WRITE = 0; HW2_RESET = 1; HW2_pcSource = 3'b000;
        #10;
        HW2_WRITE = 1; HW2_RESET = 0;
        #20;
        
        HW2_pcSource = 3'b001;
        #10;
        HW2_pcSource = 3'b010;
        #10;
        HW2_pcSource = 3'b011;
        #10;
        HW2_pcSource = 3'b100;
        #10;
        HW2_pcSource = 3'b101;
        #10;
        HW2_pcSource = 3'b110;
        #10;
        HW2_pcSource = 3'b111;
        #10;
        
        HW2_WRITE = 1; HW2_RESET = 1; HW2_pcSource = 3'b000;
        #10;
          
    end
    
    
endmodule
