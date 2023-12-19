# Student: Nathan Jaggers
# CPE 233 - Final Project
#------------------------
 #define constants
 .eqv SWITCHES 	0x11000000
 .eqv RANDOM 	0x11000010
 .eqv LEDS 	0x11000020
 .eqv SSEG 	0x11000040
 
 #include data segment if needed
 .data 
 ARRAY1:.word	0x1,	0x2,	0x4,	0x8
 		0x10,	0x20,	0x40,	0x80
		0x100,	0x200,	0x400,	0x800
		0x1000, 0x2000, 0x4000, 0x8000
 ARRAY2:.word	0x180,	0x3c0,	0x7e0,	0xff0,
 		0x1ff8,	0x3ffc,	0x7ffe,	0xffff
 #Minesweeper Program 
 .text
 
 #Initialize important starting game values
 INIT:		li sp 0x00010000
 		li s0, SWITCHES
 		la s1, ARRAY1
 		li s2, 0xFFFF
 		li s3, 0xDEAD
 		li s4, 0x5AFE
 		
 #Obtain start input from user to generate random numbers for game
 START:		sw zero, 0x20(s0)	#display nothing on the LEDS
 		sw zero, 0x40(s0)	#display nothing on the SSEG
 		lw t0, 0x4(s0)		#get start input from button
 		beqz t0, START
 		
 #Get random numbers from RNG and use to select spots for mines. Also check for duplicates.
 GETRANDS:	lw s7, 0x10(s0)			#load random number 1
 		andi s7, s7, 0x0000000F		#mask first 4 bits to get random 0-15 value
 		
 	REDO2:	lw s8, 0x10(s0)			#load random number 2
		andi s8, s8, 0x0000000F		#mask first 4 bits to get random 0-15 value
		beq s7, s8, REDO2		#if 2 matches previous number, generate new random
		
	REDO3:	lw s9, 0x10(s0)			#load random number 3
		andi s9, s9, 0x0000000F		#mask first 4 bits to get random 0-15 value
		beq s7, s9, REDO3		#if 3 matches previous number, generate new random
		beq s8, s9, REDO3
	
	REDO4:	lw s10, 0x10(s0)		#load random number 4
		andi s10, s10, 0x0000000F	#mask first 4 bits to get random 0-15 value
		beq s7, s10, REDO4		#if 4 matches previous number, generate new random
		beq s8, s10, REDO4	
		beq s9, s10, REDO4
		
	REDO5:	lw s11, 0x10(s0)		#load random number 5
		andi s11, s11, 0x0000000F	#mask first 4 bits to get random 0-15 value
		beq s7, s11, REDO5		#if 5 matches previous number, generate new random
		beq s8, s11, REDO5	
		beq s9, s11, REDO5
 		beq s10, s11, REDO5
 
 #Call Mult4 for each random number to find offset for memory location in ARRAY1 holding mine locations	
 SETMINES:	addi	a0, s7, 0
 		call	MULT4
 		add	t2, s1, a1
 		lhu	s7, 0x0(t2) 	#mine 1 set
 		
 		addi	a0, s8, 0
 		call	MULT4
 		add	t2, s1, a1
 		lhu	s8, 0x0(t2) 	#mine 2 set
 		
 		addi	a0, s9, 0
 		call	MULT4
 		add	t2, s1, a1
 		lhu	s9, 0x0(t2) 	#mine 3 set
 		
 		addi	a0, s10, 0
 		call	MULT4
 		add	t2, s1, a1
 		lhu	s10, 0x0(t2) 	#mine 4 set
 		
 		addi	a0, s11, 0
 		call	MULT4
 		add	t2, s1, a1
 		lhu	s11, 0x0(t2) 	#mine 5 set	
 
 #check to see if any SWITCHES are on before starting the game
 #if SWITCHES are on, force user to turn all off before starting
 PREGAME:	lw t0, 0x0(s0)		#load SWITCHES current value
 		sw t0, 0x20(s0)		#light switches that are on
 		li t1, 0x50FF		#load 50FF to display SOFF - SWITCHES OFF
 		sw t1, 0x40(s0)		#display instruction to turn off switches
 		bnez t0, PREGAME	#loop if SWITCHES != 0
 		li s6, 0		#s6 will hold user input history
 		li t1, 0		#load 0 into t1
 		sw t1, 0x40(s0)		#display 0000 on SSEG
 HOLD:		lw t0, 0x4(s0)		#get HOLD input from button
 		beqz t0, HOLD
 
 #Get user input from SWITCHES, see how it differs from previous selections and check for win, loss or continue
 GAME:		lw t0, 0x0(s0)		#load word from switches
 		beq t0, s6, GAME	#if current SWITCHES and previous are the same, wait for change
 		xor a0, t0, s6		#isolate bit that changed and check for lose
 		
 		call LCHECK 		#check for loss
 		bnez a1 LOSE
 		
 		add s6, t0, zero	#update input history.
 		sw s6, 0x20(s0)		#light up selected LEDs
 		
 		call WCHECK		#check for win
 		bnez a1 WIN
 		
 		call DISCHECK		#check distance from nearest mine
 		sw a1, 0x40(s0)		#print number to SSEG
 		
 		j GAME
 
 LOSE:		la a2, ARRAY2		#load address of array as argument for subroutine
 		CALL LANI
 		sw s3, 0x40(s0)		#display game over message 
 		j STOP
 		
 
 WIN:		addi a2, s6, 0		#load input history as argument for subroutine 
 		call WANI		
 		sw s4, 0x40(s0)		#display win message
 		j STOP
 
 STOP: 		lw t0, 0x8(s0)
 		beqz t0, STOP
 		j START

 #Multiply random 0-15 by 4 to get array address offset for mine location
 #argument to multiply by 4 is set in a0, result returned in a1
 MULT4:		addi sp, sp, -4		#push return address and registers to be used
		sw ra, 0x0(sp)		#return address

		addi sp, sp, -4		#extra registers
		sw t0, 0x0(sp)
		addi sp, sp, -4
		sw t1, 0x0(sp)

		li t0, 4		#load mult counter
		li a1, 0		#initialize total to zero
		
		MULT:			#multiply argument by 4 through addition loop
		beqz t0,MULTEND
		add a1,a1,a0
		addi t0,t0,-1
		j MULT
		MULTEND:
		
		lw t1, 0x0(sp)		#pop return address and registers that were saved
		addi sp, sp, 4		#extra registers
		lw t0, 0x0(sp)
		addi sp, sp, 4

		lw ra, 0x0(sp)		#return address
		addi sp, sp, 4

		ret			#return
		

 #check if input matches mines
 #if loss returns a 1 in a1, if not, returns a 0
 LCHECK:	addi sp, sp, -4		#push return address and registers to be used
		sw ra, 0x0(sp)		#return address

		li  a1, 0		#zero out a1
		beq a0, s7, LOSS	#check if new input matches any mines
		beq a0, s8, LOSS
		beq a0, s9, LOSS
		beq a0, s10, LOSS
		beq a0, s11, LOSS
		j LCEND
		
		LOSS:
		li a1, 1
		
		LCEND:
		lw ra, 0x0(sp)		#return address
		addi sp, sp, 4

		ret			#return

 #check if input matches win condition
 #if win returns a 1 in a1, if not, returns a 0
 WCHECK:	addi sp, sp, -4		#push return address and registers to be used
		sw ra, 0x0(sp)		#return address

		li  a1, 0		#zero out a1
		or t4, s7, s8		#combine all mines
		or t4, t4, s9
		or t4, t4, s10
		or t4, t4, s11
		xor t4, t4, s6		#combine mines & inputs and check if equal to 0xFFFF
		beq t4, s2, DUB		#if equal, congrats!
		j WCEND
		
		DUB:
		li a1, 1
		
		WCEND:
		lw ra, 0x0(sp)		#return address
		addi sp, sp, 4

		ret			#return	

 #check the distance from new input to closest mine
 #expects new input in a0 and returns closest distance to a1
 DISCHECK:	addi sp, sp, -4		#push return address and registers to be used
		sw ra, 0x0(sp)		#return address

		li t0, 16		#counter to hold max amount of shifts
		li t1, 0		#hold current amount of  right shifts
		addi t2, a0, 0		#load input into t2
		li t3, 0		#hold current amount of left shifts
		addi t4, a0, 0		#load input into t4
		
		RSIDE:
		srli t2, t2, 1		#shift input by one and check against mines
		addi t1, t1, 1		#add 1 to shift count
		beq t2, s7, LSIDE	#check if shift matches mine 1
		beq t2, s8, LSIDE	#check if shift matches mine 2
		beq t2, s9, LSIDE	#check if shift matches mine 3
		beq t2, s10, LSIDE	#check if shift matches mine 4
		beq t2, s11, LSIDE	#check if shift matches mine 5
		beq t1, t0, LSIDE	#check if shift reached max
		j RSIDE			
		
		LSIDE:
		slli t4, t4, 1		#shift input by one and check against mines
		addi t3, t3, 1		#add 1 to shift count
		beq t4, s7, DCEND	#check if shift matches mine 1
		beq t4, s8, DCEND	#check if shift matches mine 2
		beq t4, s9, DCEND	#check if shift matches mine 3
		beq t4, s10, DCEND	#check if shift matches mine 4
		beq t4, s11, DCEND	#check if shift matches mine 5
		beq t3, t0, DCEND	#check if shift reached max
		j LSIDE
		
		DCEND:			#evaluate which mine is closer
		bltu t1, t3, STR1	
		addi a1, t3, 0		#if left mine is closer, assign as return value 
		j DCDONE
		STR1:
		addi a1, t1, 0		#if right mine is closer, assign as return value
		
		DCDONE:
		lw ra, 0x0(sp)		#return address
		addi sp, sp, 4

		ret			#return	

 #makes program wait for selected amount of time by doing no operation instructions.
 #returns when completed
 WAIT:		addi sp, sp, -4		#push return address and registers to be used
		sw ra, 0x0(sp)		#return address
		
		#wait 0.5 seconds // each instruction takes 40ns
		#therefore we need 12,500,000 instructions
		#with 3 instructions per loop, we will load in 4,166,666 to x6
		
		li t0, 0x3F940A 	#load 4,166,666
		REPEAT: beqz t0, WEND	#check if counter is zero
		addi t0,t0,-1		#decremnet
		j REPEAT		#jump and repeat
	
		WEND:
		lw ra, 0x0(sp)		#return address
		addi sp, sp, 4

		ret			#return	
		
 #LED Animation for win
 WANI:		addi sp, sp, -16	#push return address and registers to be used
		sw ra, 0xc(sp)		#return address
		sw s2, 0x8(sp)		
		sw s3, 0x4(sp)		
		sw s4, 0x0(sp)		
		
		li s2, 0		#load 0 into s2 and display
		li s3, 3		#load counter for blink
		
		WBLINK:
		beqz s3, DACT		#if bilnked 3 times branch			
 		sw s2, 0x20(s0)		#turn off all LEDS
 		call WAIT
 		sw a2, 0x20(s0)		#turn on LEDS with input history
 		call WAIT
 		addi s3, s3, -1		#decremnent
		j WBLINK
		
		DACT:
		sw s2, 0x20(s0)		#turn off all LEDS
		call WAIT
		li s3, 16		#loop counter
		li s4, 0xFFFF		#set s4 to 0xFFFF
 		sw s4, 0x20(s0)		#turn on all LEDS
 		call WAIT
		
		DASHIFT:
		slli s4, s4, 1		#shift bits left 1 by 1 till all gone
		sw s4, 0x20(s0)		#turn on shifted LEDS
		call WAIT
		addi s3, s3, -1		#decremnent
		beqz s3, WAEND		
		j DASHIFT		
		
		WAEND:
		lw s4, 0x0(sp)		
		lw s3, 0x4(sp)		
		lw s2, 0x8(sp)		
		lw ra, 0xc(sp)		#return address
		addi sp, sp, 16

		ret			#return	
		
 #LED Animation for lose
 LANI:		addi sp, sp, -16	#push return address and registers to be used
		sw ra, 0xc(sp)		#return address
		sw s2, 0x8(sp)		
		sw s3, 0x4(sp)		
		sw s4, 0x0(sp)		
		
		li s2, 0		#load 0 into s2 and display
		li s3, 3		#load counter for blink
		
		LBLINK:
		beqz s3, BOOM		#if bilnked 3 times branch			
 		sw s2, 0x20(s0)		#turn off all LEDS
 		call WAIT
 		sw a0, 0x20(s0)		#turn on LEDS with mine bit
 		call WAIT
 		addi s3, s3, -1		#decremnent
		j LBLINK
		
		BOOM:
		sw s2, 0x20(s0)		#turn off all LEDS
		call WAIT
		li s3, 0x20		#loop max
		
		SPREAD:
		add t2, s2, a2		#get address of element in array 2
		lw t3, 0x0(t2)		#store data
		sw t3, 0x20(s0)		#turn on some LEDS
		call WAIT		
		addi s2, s2, 4		#incremnet s2 by 4
		beq s2, s3, LAEND	#if max reached, exit
		j SPREAD 
	
		LAEND:
		lw s4, 0x0(sp)		
		lw s3, 0x4(sp)		
		lw s2, 0x8(sp)		
		lw ra, 0xc(sp)		#return address
		addi sp, sp, 16

		ret			#return	
