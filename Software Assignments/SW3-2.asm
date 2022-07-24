# Student: Nathan Jaggers
# CPE 233 - SW1-1
#------------------------

#read value from SWITCHES
li x31, 0x11000000
lw x5,(x31)

#wait 0.5 seconds // each instruction takes 40ns
#therefore we need 12,500,000 instructions
#with 3 instructions per loop, we will load in 4,166,666 to x6

#li x6,0x5 #RARS will do 30 instructions per second, so this will give us a 0.5 wait
li x6, 0x3F940A 
REPEAT: beqz x6,END
addi x6,x6,-1
j REPEAT

END:
#output value to SEGMENT
sw x5,0x40(x31)
