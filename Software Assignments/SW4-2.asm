# Student: Nathan Jaggers
# CPE 233 - SW4-1
#------------------------

#load MMIO address and immediate
li t6, 0x11000000

#read value from SWITCHES
lhu t0, (t6)
lhu t1, 0x2(t6)

#initialize counter to 0
li t2, 0

#divide by t1 loop
#branch if value less than t1, otherwise increment counter and subtract value by t1
beqz t1, DONE 
LOOP: bltu t0, t1, DONE
sub t0, t0, t1
addi t2, t2, 1 
j LOOP

DONE:

#output counter as quotient to 7 SEGMENT and remaining value as remainder to LEDs 
sh t2, 0x40(t6)
sh t0, 0x20(t6)
