`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Nathan Jaggers
// 
// Create Date: 02/07/2021 09:49:52 PM 
// Description: 
//////////////////////////////////////////////////////////////////////////////////


module ControlUnitDecoder(
    input  [6:0] CUDCDR_opCode,
    input  [2:0] CUDCDR_func,
    input  CUDCDR_funcBit,
    input  CUDCDR_intrTaken,
    input  CUDCDR_brEq,
    input  CUDCDR_brLt,
    input  CUDCDR_brLtu,
    output logic [3:0] CUDCDR_aluFunc,
    output logic CUDCDR_aluSRCA,
    output logic [1:0] CUDCDR_aluSRCB,
    output logic [2:0] CUDCDR_pcSRC,
    output logic [1:0] CUDCDR_rfwSel
    );
    
    always_comb begin
        //Set all outputs to zero
                CUDCDR_aluFunc = 0;
                CUDCDR_aluSRCA = 0;
                CUDCDR_aluSRCB = 0;
                CUDCDR_pcSRC = 0;
                CUDCDR_rfwSel = 0;
                
        if (CUDCDR_intrTaken == 1'b1)begin
            CUDCDR_pcSRC = 4;
        end
        else begin            
        //case statement for outputs
            case (CUDCDR_opCode) //ir[6:0]
                7'b0110011: begin //R-type instruction
                    CUDCDR_aluSRCA = 0;
                    CUDCDR_aluSRCB = 0;
                    CUDCDR_pcSRC = 0;
                    CUDCDR_rfwSel = 3;
                    CUDCDR_aluFunc = {CUDCDR_funcBit,CUDCDR_func};
                end 
                
                7'b0010011: begin //I-type instruction
                    CUDCDR_aluSRCA = 0;
                    CUDCDR_aluSRCB = 1;
                    CUDCDR_pcSRC = 0;
                    CUDCDR_rfwSel = 3;
                        if (CUDCDR_func == 3'b101)
                            CUDCDR_aluFunc = {CUDCDR_funcBit,CUDCDR_func};
                        else
                            CUDCDR_aluFunc = {1'b0,CUDCDR_func};
                end
                
                7'b1100111: begin //I-type instruction - jalr
                    CUDCDR_aluSRCA = 0;
                    CUDCDR_aluSRCB = 1;
                    CUDCDR_pcSRC = 1;
                    CUDCDR_rfwSel = 0;
                    CUDCDR_aluFunc = {1'b0,CUDCDR_func};
                end
                
                7'b0000011: begin //I-type instruction - load
                    CUDCDR_aluSRCA = 0;
                    CUDCDR_aluSRCB = 1;
                    CUDCDR_pcSRC = 0;
                    CUDCDR_rfwSel = 2;
                    CUDCDR_aluFunc = {4'b0000};
                end
                
                7'b0100011: begin //S-type instruction
                    CUDCDR_aluSRCA = 0;
                    CUDCDR_aluSRCB = 2;
                    CUDCDR_aluFunc = {4'b0000};
                end
                
                7'b1100011: begin //B-type instruction
                    CUDCDR_pcSRC = 0;
                    case(CUDCDR_func)
                        3'b000: begin //branch equal
                            if(CUDCDR_brEq)
                                CUDCDR_pcSRC = 2;
                        end
                        
                        3'b101: begin //branch greater than or equal
                            if(~CUDCDR_brLt || CUDCDR_brEq)
                                CUDCDR_pcSRC = 2;
                        end
                        
                        3'b111: begin //branch greater than or equal unsigned
                            if(~CUDCDR_brLtu || CUDCDR_brEq)
                                CUDCDR_pcSRC = 2;
                        end
                        
                        3'b100: begin //branch less than
                            if(CUDCDR_brLt)
                                CUDCDR_pcSRC = 2;
                        end
                        
                        3'b110: begin //branch less than unsigned
                            if(CUDCDR_brLtu)
                                CUDCDR_pcSRC = 2;
                        end
                        
                        3'b001: begin //branch not equal
                            if(~CUDCDR_brEq)
                                CUDCDR_pcSRC = 2;
                        end            
                    endcase
                end
                
                7'b0110111: begin //U-type instruction - lui
                    CUDCDR_aluSRCA = 1;
                    CUDCDR_pcSRC = 0;
                    CUDCDR_rfwSel = 3;
                    CUDCDR_aluFunc = {4'b1001};                            
                end
                
                7'b0010111: begin //U-type instruction - auipc
                    CUDCDR_aluSRCA = 1;
                    CUDCDR_aluSRCB = 3;
                    CUDCDR_pcSRC = 0;
                    CUDCDR_rfwSel = 3;
                    CUDCDR_aluFunc = {4'b0000};  
                end
                
                7'b1101111: begin //J-type instruction
                    CUDCDR_pcSRC = 3;
                    CUDCDR_rfwSel = 0;
                end
                
                7'b1110011: begin //system instructions
                    if (CUDCDR_func[0] == 1'b1) begin   //csrrw
                        CUDCDR_pcSRC = 0;
                        CUDCDR_rfwSel = 1;
                        end     
                    else                                //mret
                        CUDCDR_pcSRC = 5;
                end
            default: ;//opcode default everything stays at 0
            endcase
        end
    end
    
endmodule
