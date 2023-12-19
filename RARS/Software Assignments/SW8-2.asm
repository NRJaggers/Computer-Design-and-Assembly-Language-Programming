# Student: Nathan Jaggers
# CPE 233 - SW7-1
#------------------------

#initialize stack pointer and constants
li sp 0x00010000
li s0 0x11000000
li s1 0x00006000

#set up ISR address and enable interrupts
la t0, ISR
csrrw zero, mtvec, t0
li t1, 1
csrrw zero, mie, t1

#loop continuously with no operation
Loop:	j Loop


##################################
#---Interrupt Service Rountine---#
##################################
ISR:	#push registers that will be used 
	#and shouldn't be changed for main	
	
	lw t0, 0x20(s0)		#obtain value of LEDs
	lw t1, (s0)		#obtain value of SWITCHES
	lw t2, 0x0(s1)		#obtain previous SWITCHES
	
	bne t1, t2, Cont	#if not equal, continue
	sw t0, 0x4(s1)		#store value of LEDs
	add t0, zero, zero	#zero out LEDs
	
	BTN0:
	lw t3, 0x200(s0)	#load button values
	andi t3, t3, 1		#mask bit 0
	beqz t3, BTN0		#branch if button 0 is not pressed
	
	lw t0, 0x4(s1)		#restore LEDs
	
	Cont:	
	xor t0, t0, t1 		#flip bits 
	
	sw t0, 0x20(s0)		#store new value to LEDs
	
	sw t1, 0x0(s1)		#store value of SWITCHES
	
	#pop registers that were used
	
	li t1, 1		#enable interrupts
	csrrw zero, mie, t1	
	mret 			#return
