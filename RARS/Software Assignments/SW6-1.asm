# Student: Nathan Jaggers
# CPE 233 - SW6-1
#------------------------

#initialize stack pointer and constants
li sp 0x00010000
li s0 0x11000000	
li s1 0xFFFFFFFF
li s2 0x00010000
#read value from SWITCHES
#check if value = FFFFFFFF, branch if true
Pushloop:
lw t0, (s0)
beq t0, s1, Poploop
addi sp, sp,-4
sw t0, (sp)
j Pushloop

#when value = FFFFFFFF display inputs in reverse order to LEDs
Poploop:
bge sp, s2, Done
lw t0,(sp)
addi sp, sp, 4
sw t0, 0x20(s0)
j Poploop

Done:
