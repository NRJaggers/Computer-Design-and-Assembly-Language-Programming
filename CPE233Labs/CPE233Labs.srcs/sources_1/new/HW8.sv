`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Nathan Jaggers
// 
// Create Date: 03/04/2021 06:35:34 PM 
// Description: 
//////////////////////////////////////////////////////////////////////////////////


module HW8();

    ControlStatusRegisters  HW8_CSR();
    CPU                     HW8_CPU();
    OTTER_Wrapper           HW8_OTTER_Wrapper();
    debounce_one_shot       HW8_Debounce_1Shot();

endmodule
