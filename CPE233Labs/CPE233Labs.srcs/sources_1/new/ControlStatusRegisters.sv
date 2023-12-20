`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Nathan Jaggers
// 
// Create Date: 03/04/2021 06:35:34 PM 
// Description: 
//////////////////////////////////////////////////////////////////////////////////


module ControlStatusRegisters( 
    input        CSR_RST,
    input        CSR_INT_TAKEN,
    input [11:0] CSR_ADDR,
    input        CSR_WR_EN,
    input [31:0] CSR_PC,
    input [31:0] CSR_WD,
    input        CSR_CLK,
    
    output logic        CSR_MIE,
    output logic [31:0] CSR_MEPC,
    output logic [31:0] CSR_MTVEC,
    output logic [31:0] CSR_RD 
    ); 
    
    //continuous 
    always_comb 
    begin
        
        case (CSR_ADDR)                         //read data from registers out of module
            12'h304: CSR_RD = {31'b0,CSR_MIE};  //MIE
            12'h305: CSR_RD = CSR_MTVEC;        //MTVEC
            12'h341: CSR_RD = CSR_MEPC;         //MEPC
            default: CSR_RD = 32'b0;            //if not these registers, return nothing
        endcase
        
    end
    
    //synchronous
    always_ff @(posedge CSR_CLK)
    begin
        //reset signal should reset the registers 
        if (CSR_RST == 1'b1) begin
            //reset registers individually
            CSR_MIE    <= 0;
            CSR_MEPC   <= 32'b0;
            CSR_MTVEC  <= 32'b0;
            end
            
        else if (CSR_INT_TAKEN == 1'b1) //if interrupt is taken, disable future interrupts, save PC
            begin           
                CSR_MIE  <= 1'b0;    //disable interrupts
                CSR_MEPC <= CSR_PC;  //save PC to MEPC
            end
            
        else if(CSR_WR_EN)//synchronus write to registers  
            begin
                case (CSR_ADDR)                     //write data to registers
                12'h304: CSR_MIE   <= CSR_WD[0];    //MIE
                12'h305: CSR_MTVEC <= CSR_WD;       //MTVEC
                12'h341: CSR_MEPC  <= CSR_WD;       //MEPC
                endcase             
            end
            

  
    end
    
endmodule
