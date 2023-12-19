# Student: Nathan Jaggers
# CPE 233 - SW1-1
#------------------------

#define constant
.eqv SWITCHES, 0x11000000
.eqv SEGMENT7, 0x11000040

li x10, SEGMENT7

#read in value from SWITCHES
lw x5, SWITCHES

#load in comparative value to register
li x6, 32768

#test value and branch
bgeu x5, x6, DIV

MUL: slli x7,x5,1
j END

DIV: srli x7,x5,2
END:

#store value into SEGMENT
sw x7, (x10)