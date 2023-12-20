`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////// 
// Engineer: Nathan Jaggers
// 
// Create Date: 02/10/2021 05:51:41 PM
//////////////////////////////////////////////////////////////////////////////////


module CPU_Sim();

//define logic
    logic  CPU_RST;
    logic  CPU_INTR;
    logic  [31:0] CPU_IOBUS_IN;
    logic  CPU_CLK;
    logic CPU_IOBUS_WR;
    logic [31:0] CPU_IOBUS_OUT;
    logic [31:0] CPU_IOBUS_ADDR;
    
//CPU instance
    CPU MCU_V1(.*);
    
//test cases
    always
    begin
        CPU_CLK = 0;
        #5;
        CPU_CLK = 1;
        #5;
    end
    
    initial begin
        //otter.mem sim
//        CPU_RST = 1; CPU_INTR = 0; CPU_IOBUS_IN = 32'h00000000;
//        #10;
//        CPU_RST = 0;
//        #180;
//        CPU_RST = 1;
//        #10;
//        CPU_RST = 0;
//        #100;
//        CPU_RST = 1;
//        #30;
//        CPU_RST = 0;
        
        //test all sim
        CPU_RST = 1; CPU_INTR = 0; CPU_IOBUS_IN = 32'h00000000;
        #10;
        CPU_RST = 0;
        
    end 

endmodule
