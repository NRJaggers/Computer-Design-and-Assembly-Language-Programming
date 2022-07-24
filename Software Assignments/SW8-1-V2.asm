# Student: Nathan Jaggers
# CPE 233 - SW7-1
#------------------------

#initialize stack pointer and constants
li sp 0x00010000
li s0 0x11000000

#set up ISR address and enable interrupts
la t0, ISR
csrrw zero, mtvec, t0
li t1, 1
csrrw zero, mie, t1

#loop continuously with no operation
Loop:	j Loop


#################################
#---Interrupt Service Routine---#
#################################
ISR:	#push registers that will be used 
	#and shouldn't be changed for main	
	
	lw t0, 0x20(s0)	#obtain value of LEDs
	lw t1, (s0)	#obtain value of SWITCHES
	
	xor t1, t0, t1 	#flip bits 
	
	sw t1, 0x20(s0)	#store new value to LEDs
	
	#pop registers that were used
	
	li t1, 1		#enable interrupts
	csrrw zero, mie, t1	
	mret 			#return
