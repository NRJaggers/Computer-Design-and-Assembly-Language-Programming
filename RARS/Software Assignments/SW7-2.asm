# Student: Nathan Jaggers
# CPE 233 - SW7-2
#------------------------

#initialize stack pointer and constants
li sp 0x00010000
li s0 0x11000000	

#read value from SWITCHES to arguments
lhu a0, 0x0(s0)
lhu a1, 0x0(s0)

#call GCD subroutine
call GCD

#output results to LEDs
sh a0, 0x20(s0)
Done: j Done

################################
###########---GCD---############
################################
GCD:

#push return address and registers to be used
#return address
addi sp, sp, -4
sw ra, 0x0(sp)

beq a0, a1, returnVal
bgt a0, a1, recur1
sub a1, a1, a0
j recur2

recur1:
sub a0, a0, a1
recur2:
call GCD

returnVal:

#return address
lw ra, 0x0(sp)
addi sp, sp, 4

#return
ret