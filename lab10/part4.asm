# An array manipulation program
# begins with A[5] empty


	# Declare main as a global function
	.globl main
	
	# All Program code is placed after the
	# .text assembler directive
	.text
	
# The label 'main' represents the starting point
main:
	# store values to be used for A, B, and loops 
	la $t0, A		# place address of A in register t0, A pointer
	la $t1, B		# place address of B in register t1, B pointer
	lw $s0, C               # place address of c in s0
	li $t3, 0		# place 0 in t3, this is i
	li $t5, 19		# place 19 in register t5
	li $t8, 2		# place 2 in register t8
	
	# first loop (i=0;i<5;i++){A[i]=B[i]+C;}
	# will loop for i<20;i=i+4 because the width of A and B is 4 bytes
loop1:  bgt  $t2, $t5, next	# loop while (i < 20) branch when (i > 19)
	add  $t3, $t0, $t2	# find A[i]
	add  $t4, $t1, $t2	# find B[i]
	lw   $t6, 0($t3)	# load A[i] in t6
	lw   $t7, 0($t4)	# load B[i] in t7
	add $t6, $t7, $s0	# A[i] = B[i]+C
	sw   $t6, 0($t3)	# store A[i]
	addi $t2, $t2, 4	# (i+4) or i++
	j    loop1		# keep looping
	
next: 	addi $t2, $t2, -4	# i--

	# second loop while(i>=0){A[i]=A[i]*2; i--;}
	# will loop while i>=0;i=i-4 because the width of A and B is 4 bytes
loop2:	blt  $t2, $zero, end 	# branch when less than 0
	add  $t3, $t0, $t2	# find A[i]
	lw   $t6, 0($t3)	# load A[i] in t6
	mul  $t6, $t6, $t8	# A[i]=A[i]*2
	sw   $t6, 0($t3)	# store A[i]
	addi $t2, $t2, -4	# i--
	j    loop2
	
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
A: .space 20			# A = initially an empty array 5 words long
B: .word  1,2,3,4,5		# B[5]={1,2,3,4,5}
C: .word  12
