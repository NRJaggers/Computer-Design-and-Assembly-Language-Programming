# Student: Nathan Jaggers
# CPE 233 - SW1-1
#------------------------

#read value from SWITCHES
li x31,0x11000000
lw x5,(x31)

#split 32-bit unsigned value into 2 16-bit unsigned values
lhu x6,0(x31)
srli x7,x5,16

#multiply the two values through addition loop
MULT:
beqz x6,END
add x8,x8,x7
addi x6,x6,-1
j MULT
END:

#output result to SEGMENT
sw x8,0x40(x31)