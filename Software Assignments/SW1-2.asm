# Student: Nathan Jaggers
# CPE 233 - SW1-2
#------------------------

#define constants
 .eqv SWITCHES 	0x11000000
 .eqv LEDS 	0x11000020
 
#load registers with memory locations
 li x5, SWITCHES 
 li x6, LEDS
 
#load SWITCHES value into registers
 lh x7, 0(x5) 
 
#flip bits
 not x7,x7
 
#add one together
 addi x8,x7,1

#output result
 sh x8, 0(x6)
 