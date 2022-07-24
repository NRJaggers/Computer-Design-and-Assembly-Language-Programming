# Student: Nathan Jaggers
# CPE 233 - SW1-1
#------------------------

#define constants
 .eqv SWITCHES 	0x11000000
 .eqv LEDS 	0x11000020
 
#load registers with memory locations
 li x5, SWITCHES 
 li x6, LEDS
 
#load SWITCHES values into registers
 lhu x7, 0(x5) 
 lhu x8, 2(x5)
 lhu x9, 4(x5)
 
#add values together
 add x10,x7,x8
 add x10,x9,x10

#output sum 
 sh x10, 0(x6)
 
