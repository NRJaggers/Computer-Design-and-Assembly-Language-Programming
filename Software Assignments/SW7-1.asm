# Student: Nathan Jaggers
# CPE 233 - SW7-1
#------------------------

#initialize stack pointer and constants
li sp 0x00010000
li s0 0x11000000	

#initialize shift and save values to zero
add s3, zero, zero	#shift value
add s4, zero, zero	#BCD value

#read value from SWITCHES to argument 
lhu a0, 0x0(s0)

#turn hex value into binary coded decimal
loop:
beqz a0, output		#output if no value is left
call Div10
sll t0, a1, s3 		#shift left by magnitude of diget we are on (times 4)
add s4, s4, t0		#save current BCD
addi s3, s3, 4		#increment value we shift by
j loop

#output value to 7 SEGMENT
output:
sw s4, 0x40(s0)
Done: j Done		#loop when finished


################################
##########---Div10---###########
################################
Div10:

#push return address and registers to be used
#return address
addi sp, sp, -4
sw ra, 0x0(sp)

#extra registers
addi sp, sp, -4
sw t0, 0x0(sp)
addi sp, sp, -4
sw t1, 0x0(sp)

#initialize counter to 0 and t1 to 10
addi t0, zero, 0
addi t1, zero, 10

#divide by 10 loop
#branch if value less than t1, otherwise increment counter and subtract value by t1
Div10_LOOP: 
bltu a0, t1, Div10_DONE
sub a0, a0, t1
addi t0, t0, 1 
j Div10_LOOP

Div10_DONE:

#output counter as quotient to 7 a0 and remaining value as remainder to a1 
add a1, a0, zero
add a0, t0, zero

#pop return address and registers that were saved
#extra registers
lw t1, 0x0(sp)
addi sp, sp, 4
lw t0, 0x0(sp)
addi sp, sp, 4

#return address
lw ra, 0x0(sp)
addi sp, sp, 4

#return
ret