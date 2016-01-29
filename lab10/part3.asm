# A simple looping program with initial values Z=5 and i=0 and final 

	# Declare main as a global function
	.globl main
	
	# All Program code is placed after the
	# .text assembler directive
	.text
	
# The label 'main' represents the starting point
main:
	# store values to be used for Z depending on comparisons 
	lw $t0, Z		# place Z in register t0
	lw $t1, i		# place i in register t1
	li $t2, 10		# place 10 in register t2
	li $t3, 0		# place 0 in register t3
	li $t4, 10		# place 10 in register t4
	
	# first loop (i=0;i<10;i++) Z++
loop1:  beq  $t1, $t2, loop2	# loop while (i <10) or until (i >= 10)
	addi $t0, $t0, 1	# Z++
	addi $t1, $t1, 1	# i++
	j    loop1		# keep looping

	# second loop while(Z>0) Z--
loop2:  beq  $t0, $t3, loop3	# exit loop
        addi $t0, $t0, -1	# Z--
	j    loop2		# keep looping
	
	# third loop while(i>0) Z--, i--
loop3:  addi $t0, $t0, 1	# Z++
	beq  $t0, $t4 end	# z<10
        j    loop3		# keep looping	
	
	# place i and Z back in memory
end:    sw   $t0, Z  		# store Z back in memory
	sw   $t1, i		# store i back in memory
	
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
Z: .word 5			# Z = 5 initially
i: .word 0			# i = 0 initially	
