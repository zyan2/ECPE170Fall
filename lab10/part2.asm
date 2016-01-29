# A simple comparison program demostrating the use of branches

	# Declare main as a global function
	.globl main
	
	# All Program code is placed after the
	# .text assembler directive
	.text
	
# The label 'main' represents the starting point
main:
	# store values to be used for Z depending on comparisons 
	li  $t0, 1		# place 1 in t0
	li  $t1, 2		# place 2 in t1
	li  $t2, 3		# place 3 in t2
	li  $t3, -1		# place -1 in t3
	li  $t5, 0		# store 0 in t5, default value
	lw  $t6, A		# place A in register t6
	lw  $t7, B		# place B in register t7
	lw  $t8, C		# place C in register t8
	lw  $t9, Z		# place Z in register t9
	
	# Comparison code
	bgt $t6, $t7, AlsB	# check A > B
	blt $t6, $t7, Zis2	# check A < B
	add $t4, $t8, $t0	# C+1 stored in t4
	beq $t4, 7, Zis2	# (C+1)==7
AlsB:	bgt $t8, 4, Zis1	# check C >= 5
	j   Zis1		# go to Z = 1
	
	# Set Z based on comparisons
Zis1:   move$t9, $t0		# Z = 1
	j   case		# go to case statements

Zis2:	move$t9, $t1		# Z = 2
	j   case		# go to case statements
	  
Zis3:   move$t9, $t2		# Z = 3
	j   case		# go to case statements

	# Check value of Z set based on comparisons
case:   beq $t9, 1, case1	# if Z = 1
				# go to case1 to set Z = -1
	beq $t9, 2, case2	# if Z = 2
				# go to case 2 to set Z = -2
	beq $t9, 3, case3	# if Z = 3
				# go to case 3 to set Z = -3
	sw  $t5, Z		# default Z = 0
	j   end			# break go to end of program
	
	# Set new value of Z based on Case Statement
case1:  sw  $t3, Z		# Z = -1
	j   end			# break go to end of program

case2:  mul $t4, $t3, $t1	# t4 = -1*2
	sw  $t4, Z		# Z = -2  
	j   end			# break go to end of program
	
case3:  mul $t4, $t3, $t2	# t4 = -1*3
	sw  $t4, Z		# Z = -3
	
	# Exit the program by means of a syscall.
	# There are many syscalls - pick the desired one
	# by placing its code in $v0. The code for exit is "10"
end:	li   $v0, 10 		# Sets $v0 to "10" to select exit syscall
	syscall 		# Exit

	# All memory structures are placed after the
	# .data assembler directive
	.data

	# The .word assembler directive reserves space
	# in memory for a single 4-byte word (or multiple 4-byte words)
	# and assigns that memory location an initial value
	# (or a comma separated list of initial values)
Z: .word 0			# Z = 0 initially
A: .word 10			# A = 10
B: .word 15			# B = 15
C: .word 5			# C = 5
