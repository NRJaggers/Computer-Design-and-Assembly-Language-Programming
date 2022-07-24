# Student: Nathan Jaggers
# CPE 233 - SW4-1
#------------------------

#define data in data segment
.data
ARRAY: .space 40	#allocate 40 bytes for 10 32-bit values in array
	     
#write code to perform task
.text 

#load immediates to access data and outputs
li s0, 0x11000000
la s1, ARRAY
#value for end of array?

#load counter for input values
li t0, 10
la t2, ARRAY

#load values from SWITCHES into array
LOOP1:
beqz t0, DONE1
lw t1, (s0)
sw t1, (t2)
addi t2, t2, 0x4
addi t0, t0, -1
j LOOP1 

DONE1:

#bubble sort array
li t0, 0x24	#initialize counter
LOOP2.1:
beqz t0, DONE2.1

addi t1, t0, -4	#initialize counter
LOOP2.2:
beqz t1, DONE2.2

add t3, s1, t1
add t4, t1, -4 

lw t5, t3
lw t6, t4

blt t6, t5, NEXT
sw t6, t3
sw t5, t4 

NEXT:
addi t1, t1, -4

j LOOP2.2
DONE2.2:

j LOOP2.1
DONE2.1:

#create counters for outputing data
li t0, 10
la t2, ARRAY
addi t3, s0, 0x20	#comment out if outputing result strictly to 0x11000020
			#otherwise output will be seen from 0x11000020 to 0x11000060

#output array to LEDS
LOOP3:
beqz t0, DONE3
lw t1, (t2)		#loading value from array
sw t1, (t3)		#outputing value to MMIO // if result strictly to 0x11000020 use : sw t1, 0x20(s0)
addi t2, t2, 0x4	#increment array index
addi t3, t3, 0x4	#incrememnt memory store location  // if result strictly to 0x11000020 comment out
addi t0, t0, -1		#decrement counter
j LOOP3 

DONE3: