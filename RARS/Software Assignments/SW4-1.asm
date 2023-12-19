# Student: Nathan Jaggers
# CPE 233 - SW4-1
#------------------------

#load MMIO address and immediate
li t6, 0x11000000
li t5, 3 

#read value from SWITCHES
lh t0, (t6)

#initialize counter to 0
li t1, 0

#divide by 3 loop
#branch if value less than three, otherwise increment counter and subtract value by 3
LOOP: blt t0, t5, DONE
sub t0, t0, t5
addi t1, t1, 1 
j LOOP

DONE:

#output counter as quotient to 7 SEGMENT and remaining value as remainder to LEDs 
sh t1, 0x40(t6)
sh t0, 0x20(t6)