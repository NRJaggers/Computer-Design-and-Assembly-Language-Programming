# Student: Nathan Jaggers
# CPE 233 - SW1-1
#------------------------

#initializing register
li x31, 0x11000000
li x30, 0x00000fff #4095 in decimal

#read in value from memory
lw x6, (x31)

#determine if divisible by 4
#find remiander and compare to zero
srli x7, x6, 2   #divide by 4
slli x8, x7, 2   #multiply by 4
xor  x9, x6, x8  #isolate remainder
beqz x9, CON1	 #if remainder is zero, jump

#determine if divisible by 2 (if even)
#find remiander and compare to zero
srli x7, x6, 1   #divide by 2
slli x8, x7, 1   #multiply by 2
xor  x9, x6, x8  #isolate remainder
beqz x9, CON2	 #if remainder is zero, jump

#if neither than subtract one and jump to end
CON3: addi x10, x6, -1
j END

CON1: not x10, x6 
j END

CON2: add x10,  x6, x30
     srli x10, x10, 1

END:

#store value into SEGMENT
sw x10, 0x40(x31)