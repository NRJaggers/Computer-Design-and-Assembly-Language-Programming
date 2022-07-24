# Student: Nathan Jaggers
# CPE 233 - HW1-Example
#------------------------

main: 	
	addi x5, x0, 0x05
	addi x6, x0, 0x64
	add x6, x5, x6
	slli x5, x5, 0x02
	or x6, x6, x5
	j main
