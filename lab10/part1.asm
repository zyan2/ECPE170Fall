# A simple arithmetic program for the equation
# Z = (A+B) - (C*D) + (E-F) - (A/C) where
# A = 10
# B = 15
# C = 5
# D = 2
# E = 7
# F = -3
# Z = 0
# After the program runs Z = 23

	# Declare main as a global function
	.globl main
	
	# All Program code is places after the
	# .text assembler directive
	.text
	
# The label 'main' represents the starting point
main:
	li   $s0, 10		# 'A' 
	li   $s1, 15		# 'B' 
	li   $s2, 5		# 'C' 
	li   $s3, 2		# 'D' 
	li   $s4, 7		# 'E' 
	li   $s5, -3		# 'F' 
	div  $s0, $s2	        # A/C  
	mflo $t0			
	add  $t1, $s0, $s1	# (A+B)
	mul  $t2, $s2, $s3	# (C*D)
	sub  $t3, $s4, $s5	# (E-F)
	sub  $t4, $t1, $t2	# (A+B)-(C*D)
	add  $t5, $t4, $t3	# (A+B)-(C+D)+(E-F)
	sub  $t6, $t5, $t0	# (A+B)-(C+D)+(E-F)-(A/C)
	sw   $t6, Z		# Z = A stored in Z
	
	# Exit the program by means of a syscall.
	# There are many syscalls - pick the desired one
	# by placing its code in $v0. The code for exit is "10"
	li   $v0, 10 		# Sets $v0 to "10" to select exit syscall
	syscall 		# Exit

	# All memory structures are placed after the
	# .data assembler directive
	.data

	# The .word assembler directive reserves space
	# in memory for a single 4-byte word (or multiple 4-byte words)
	# and assigns that memory location an initial value
	# (or a comma separated list of initial values)
Z: .word 0			# Z = 0 initially
