# Student: Nathan Jaggers
# CPE 233 - Final Project
#------------------------
 #define constants
 .eqv SWITCHES 	0x11000000
 .eqv RANDOM 	0x11000010
 .eqv LEDS 	0x11000020
 .eqv SSEG 	0x11000040
 
 #everytime right button is pressed, give new random number and display to SSEG
 li s0, SWITCHES
 li s2, 0x0000FFFF
 li s3, 0
 
 		NEXT:		
 		lw t0, 0x4(s0)		#check for press
 		beqz t0, NEXT		#loop if not pressed
 		
 		#random check
 		lw s1, 0x10(s0)		#save random into s1
 		and s1, s1, s2		#mask first 16 bits
 		sw s1, 0x40(s0)		#store random into SSEG
 		
 
 		#button check
 		#addi s3, s3, 1		#increment counter
 		#sw s3, 0x40(s0)		#store value into SSEG
 		
 		LOOP:
		lw t0, 0x8(s0)		#check for press
 		beqz t0, LOOP		#loop if not pressed
 		j NEXT