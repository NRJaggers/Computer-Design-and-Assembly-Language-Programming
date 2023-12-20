`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Nathan Jaggers
// 
// Create Date: 01/28/2021 09:43:27 PM
//////////////////////////////////////////////////////////////////////////////////


module ArithmeticLogicUnit_Sim();
    logic [31:0] ALU_A;
    logic [31:0] ALU_B;
    logic  [3:0] ALU_func;
    logic [31:0] ALU_result;
    
    ArithmeticLogicUnit ALU (.*);
    
    initial begin //initial or always_comb? does it matter
    //insert test cases
    //ADD
    ALU_A = 32'hA50F96C3;   ALU_B = 32'h5AF0693C; ALU_func = 4'b0000;
    #10;
    ALU_A = 32'h84105F21;	ALU_B = 32'h7B105FDE;
    #10;    
    ALU_A = 32'hFFFFFFFF;	ALU_B = 32'h00000001;
    #10;
    //SUB
    ALU_A = 32'h00000000;	ALU_B = 32'h00000001; ALU_func = 4'b1000;
    #10;
    ALU_A = 32'hAA806355;	ALU_B = 32'h550162AA;
    #10;
    ALU_A = 32'h550162AA;	ALU_B = 32'hAA806355;
    #10;
    //AND
    ALU_A = 32'hA55A00FF;	ALU_B = 32'h5A5AFFFF; ALU_func = 4'b0111;
    #10;
    ALU_A = 32'hC3C3F966;	ALU_B = 32'hFF669F5A;
    #10;
    //OR
    ALU_A = 32'h9A9AC300;	ALU_B = 32'h65A3CC0F; ALU_func = 4'b0110;
    #10;
    ALU_A = 32'hC3C3F966;	ALU_B = 32'hFF669F5A;
    #10;
    //XOR
    ALU_A = 32'hAA5500FF;	ALU_B = 32'h5AA50FF0; ALU_func = 4'b0100;
    #10;
    ALU_A = 32'hA5A56C6C;	ALU_B = 32'hFF00C6FF;
    #10;
    //SRL
    ALU_A = 32'h805A6CF3;	ALU_B = 32'h00000010; ALU_func = 4'b0101;
    #10;
    ALU_A = 32'h705A6CF3;	ALU_B = 32'h00000005;
    #10;
    ALU_A = 32'h805A6CF3;	ALU_B = 32'h00000000;
    #10;
    ALU_A = 32'h805A6CF3;	ALU_B = 32'h00000100;
    #10;
    //SLL
    ALU_A = 32'h805A6CF3;	ALU_B = 32'h00000010; ALU_func = 4'b0001;
    #10;
    ALU_A = 32'h805A6CF3;	ALU_B = 32'h00000005;
    #10;
    ALU_A = 32'h805A6CF3;	ALU_B = 32'h00000100;
    #10;
    //SRA
    ALU_A = 32'h805A6CF3;	ALU_B = 32'h00000010; ALU_func = 4'b1101;
    #10;
    ALU_A = 32'h705A6CF3;	ALU_B = 32'h00000005;
    #10;
    ALU_A = 32'h805A6CF3;	ALU_B = 32'h00000000;
    #10;
    ALU_A = 32'h805A6CF3;	ALU_B = 32'h00000100;
    #10;
    //SLT
    ALU_A = 32'h7FFFFFFF;	ALU_B = 32'h80000000; ALU_func = 4'b0010;
    #10;
    ALU_A = 32'h80000000;	ALU_B = 32'h00000001;
    #10;
    ALU_A = 32'h00000000;	ALU_B = 32'h00000000;
    #10;
    ALU_A = 32'h55555555;	ALU_B = 32'h55555555;
    #10;
    //SLTU
    ALU_A = 32'h7FFFFFFF;	ALU_B = 32'h80000000; ALU_func = 4'b0011;
    #10;
    ALU_A = 32'h80000000;	ALU_B = 32'h00000001;
    #10;
    ALU_A = 32'h00000000;	ALU_B = 32'h00000000;
    #10;
    ALU_A = 32'h55AA55AA;	ALU_B = 32'h55AA55AA;
    #10;
    //LUI-COPY
    ALU_A = 32'h01234567;	ALU_B = 32'h76543210; ALU_func = 4'b1001;
    #10;
    ALU_A = 32'hFEDCBA98;	ALU_B = 32'h89ABCDEF;
    #10;

    end

endmodule
