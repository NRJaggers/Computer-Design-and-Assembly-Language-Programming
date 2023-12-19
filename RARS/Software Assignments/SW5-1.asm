# Student: Nathan Jaggers
# CPE 233 - SW4-1
#------------------------

#define data in data segment
.data
#byte and halfword would be to small to hold some of the numbers in the array
ARRAY: .word 0, 	1, 	1, 	2, 	3, 
	     5, 	8, 	13, 	21, 	34, 
	     55, 	89, 	144, 	233, 	377, 
	     610, 	987, 	1597, 	2584, 	4181, 
	     6765, 	10946, 	17711, 	28657, 	
END:	     46368
	     
#write code to perform task
.text 

#load immediates to access data and outputs
li s0, 0x11000000
la s1, ARRAY
la s2, END

#load counter for array index values
addi t0, s1, 0
addi t1, s1, 12

#step through array and compare numbers
#if index is greater than 25, leave loop
LOOP:
bgt t1, s2, DONE	#branch if t1 is greater than end of array
lw t4, (t0)		#load value from array into register
lw t5, (t1)		#load value from array into register
sub t6, t5, t4		#find difference between values

sw t6, 0x20(s0)		#store value into LEDS

addi t0, t0, 4		#increment first counter
addi t1, t1, 4		#increment second counter

j LOOP

DONE:

