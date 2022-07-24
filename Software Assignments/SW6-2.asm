# Student: Nathan Jaggers
# CPE 233 - SW4-1
#------------------------

#initialize stack pointer and constants
li sp 0x00010000
li s0 0x11000000	
li s1 0xFFFFFFFF
li t6 0x0000fffc

#read value from SWITCHES
#check if value = FFFFFFFF, branch if true
Pushloop:
lw t0, (s0)
beq t0, s1, Poploop
addi sp, sp,-4
sw t0, (sp)
j Pushloop

#when value = FFFFFFFF display inputs in order to LEDs
Poploop:
blt t6, sp, Done
lw t0,(t6)
addi t6, t6, -4
sw t0, 0x20(s0)
j Poploop

Done:
#pop stack/reset value of stack pointer
li sp 0x00010000