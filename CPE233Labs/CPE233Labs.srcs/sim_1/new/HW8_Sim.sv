`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////// 
// Engineer: Nathan Jaggers
// 
// Create Date: 03/05/2021 12:49:23 PM
//////////////////////////////////////////////////////////////////////////////////

module HW8_Sim();

//define logic
    logic  CPU_RST;
    logic  CPU_INTR;
    logic  [31:0] CPU_IOBUS_IN;
    logic  CPU_CLK;
    logic CPU_IOBUS_WR;
    logic [31:0] CPU_IOBUS_OUT;
    logic [31:0] CPU_IOBUS_ADDR;
    
//CPU instance
    CPU MCU_V2(.*);
    
//test cases
    always
    begin
        CPU_CLK = 0;
        #5;
        CPU_CLK = 1;
        #5;
    end
    
    initial begin
        
//        //test all sim
//        CPU_RST = 1; CPU_INTR = 0; CPU_IOBUS_IN = 32'h00000000;
//        #10;
//        CPU_RST = 0;
        
        //test interrupt sim
        CPU_RST = 1; CPU_INTR = 0; CPU_IOBUS_IN = 32'h00000000;
        #10;
        CPU_RST = 0;
        #250;
        CPU_INTR = 1;
        #60;
        CPU_INTR = 0;
        #40;
        CPU_INTR = 1;
        #60;
        CPU_INTR = 0;
        #40;
        CPU_INTR = 1;
        #60;
        CPU_INTR = 0;
        #40;
        
        CPU_RST = 1;
        #10;
        CPU_RST = 0;
        #250;
        CPU_INTR = 1;
        #60;
        CPU_INTR = 0;
        #40;
        CPU_INTR = 1;
        #60;
        CPU_INTR = 0;
        #40;
        CPU_INTR = 1;
        #60;
        CPU_INTR = 0;
        #40;
        CPU_INTR = 1;
        #60;
        CPU_INTR = 0;
        #40;
        CPU_INTR = 1;
        #60;
        CPU_INTR = 0;
        #40;
        CPU_INTR = 1;
        #60;
        CPU_INTR = 0;
        #40;
    end 

endmodule

