`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Nathan Jaggers
// 
// Create Date: 01/28/2021 01:19:36 PM
// Description: 
//////////////////////////////////////////////////////////////////////////////////


module ArithmeticLogicUnit(
    input        [31:0] ALU_A,
    input        [31:0] ALU_B,
    input         [3:0] ALU_func,
    output logic [31:0] ALU_result
    );

    always_comb begin
    
    //perform aritmetic and logic on a and b
    //use mux to select output and assign output to result
    //blank comments indicate unused value
        case (ALU_func)
            4'b0000: ALU_result = $signed(ALU_A) + $signed(ALU_B) ;         //ADD (addition) - no signed needed cause bitwise
            4'b0001: ALU_result = ALU_A << ALU_B[4:0] ;                     //SLL (logical shift left)
            4'b0010: ALU_result = $signed(ALU_A) < $signed(ALU_B) ? 1:0 ;   //SLT (Set if less than)
            4'b0011: ALU_result = ALU_A < ALU_B ? 1:0;                      //SLTU (Set if less than unsigned)
            4'b0100: ALU_result = ALU_A ^ ALU_B ;                           //XOR (bitwise exclusive OR)
            4'b0101: ALU_result = ALU_A >> ALU_B[4:0] ;                     //SRL (Logical shift right)
            4'b0110: ALU_result = ALU_A | ALU_B  ;                          //OR (bitwise inclusive OR)
            4'b0111: ALU_result = ALU_A & ALU_B ;                           //AND (bitwise AND)
            4'b1000: ALU_result = $signed(ALU_A) - $signed(ALU_B) ;         //SUB (subtract) - no signed needed cause bitwise
            4'b1001: ALU_result = ALU_A;                                    //LUI-COPY (load upper immediate copy)
            //4'b1010: ; //
            //4'b1011: ; //
            //4'b1100: ; //
            4'b1101: ALU_result = $signed (ALU_A) >>> ALU_B[4:0] ;                    //SRA (Arithmetic shift right)
            //4'b1110: ; //
            //4'b1111: ; //
            default: ALU_result = 8'h00000000;
        
        endcase
    
    end
    
endmodule
