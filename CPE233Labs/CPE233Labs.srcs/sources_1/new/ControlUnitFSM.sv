`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Nathan Jaggers
// 
// Create Date: 02/07/2021 09:49:52 PM 
// Description: 
//////////////////////////////////////////////////////////////////////////////////


module ControlUnitFSM(
    input  CUFSM_rst,
    input  CUFSM_Interupt,
    input  [6:0] CUFSM_opCode,
    input  [2:0] CUFSM_func, 
    input  CUFSM_clk,
    output logic CUFSM_pcWr,
    output logic CUFSM_regWr,
    output logic CUFSM_memWrEn2,
    output logic CUFSM_memRdEn1,
    output logic CUFSM_memRdEn2,
    output logic CUFSM_Reset,
    output logic CUFSM_csrWE,
    output logic CUFSM_intrTaken
    
    );
    
    //create signal type for state register
    typedef enum{ST_INIT, ST_FETCH, ST_EXEC, ST_WRTBK, ST_INTR} STATES; 
    
    //create signals to hold state values
    STATES PS, NS ;
    
    //FSM State Register
    always_ff @(posedge CUFSM_clk) begin
        if (CUFSM_rst == 1'b1)
            PS <= ST_INIT;
        else
            PS <= NS;
    end
    
    //FSM NS Output Logic
    always_comb begin
    
        //Set all outputs to zero
            CUFSM_pcWr = 0;
            CUFSM_regWr = 0;
            CUFSM_memWrEn2 = 0;
            CUFSM_memRdEn1 = 0;
            CUFSM_memRdEn2 = 0;
            CUFSM_Reset = 0;
            CUFSM_csrWE = 0;
            CUFSM_intrTaken = 0;
        //case statement for PS
            case (PS) 
                ST_INIT: begin
                    CUFSM_Reset = 1;
                    NS = ST_FETCH; 
                end
                
                ST_FETCH: begin
                    CUFSM_memRdEn1 = 1;
                    NS = ST_EXEC;
                end
                
                ST_EXEC: begin
                    NS = ST_FETCH;  //if instruction is not a load and if
                                    //interrupt isn't true, NS will stay FETCH
                    if (CUFSM_Interupt == 1'b1) begin
                        NS = ST_INTR;
                    end
                    
                    //case statement for opcode
                        case (CUFSM_opCode) //ir[6:0]
                            7'b0110011: begin //R-type instruction
                                CUFSM_pcWr = 1;
                                CUFSM_regWr = 1;
                            end 
                            
                            7'b0010011: begin //I-type instruction
                                CUFSM_pcWr = 1;
                                CUFSM_regWr = 1;
                            end
                            
                            7'b1100111: begin //I-type instruction - jalr
                                CUFSM_pcWr = 1;
                                CUFSM_regWr = 1;
                            end
                            
                            7'b0000011: begin //I-type instruction - load
                                CUFSM_memRdEn2 = 1;
                                NS = ST_WRTBK;
                            end
                            
                            7'b0100011: begin //S-type instruction
                                CUFSM_pcWr = 1;
                                CUFSM_memWrEn2 = 1;
                            end
                            
                            7'b1100011: begin //B-type instruction
                                CUFSM_pcWr = 1;
                            end
                            
                            7'b0110111: begin //U-type instruction - lui
                                CUFSM_pcWr = 1;
                                CUFSM_regWr = 1;
                            end
                            
                            7'b0010111: begin //U-type instruction - auipc
                                CUFSM_pcWr = 1;
                                CUFSM_regWr = 1;
                            end
                            
                            7'b1101111: begin //J-type instruction
                                CUFSM_pcWr = 1;
                                CUFSM_regWr = 1;
                            end
                            
                            7'b1110011: begin //system instructions
                                if (CUFSM_func[0] == 1'b1) begin    //csrrw
                                    CUFSM_pcWr = 1;
                                    CUFSM_regWr = 1;
                                    CUFSM_csrWE = 1;
                                    end     
                                else                                //mret
                                    CUFSM_pcWr = 1;
                            end
                            
                        default: ;//opcode default everything stays at 0
                        endcase
                end
                
                ST_WRTBK: begin
                    CUFSM_pcWr = 1;
                    CUFSM_regWr = 1;
                    
                    if (CUFSM_Interupt == 1'b1)
                        NS = ST_INTR; 
                    else 
                        NS = ST_FETCH; 
                end
                
                ST_INTR: begin
                    CUFSM_pcWr = 1 ;
                    CUFSM_intrTaken = 1 ;
                    NS = ST_FETCH;
                end 
                
                default: begin //PS default
                    NS = ST_INIT;
                end
                
            endcase
    
    end
    
endmodule
