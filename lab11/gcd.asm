# A demonstration of some simple MIPS instructions
# used to test QtSPIM

	# Declare main as a global function
	.globl main 

	# All program code is placed after the
	# .text assembler directive
	.text 		

# The label 'main' represents the starting point
main:
	li $t0, 0            #i = 0
	li $s0, 1            #range from 1
	li $s1, 100000       #range end in 100000
	loop:                # start the loop
	beq $t0, 10,finish   # (i=0;i<10;i++)
	#a = random_in_range(1,10000);
	move $a0, $s0        #load in a0
	move $a1, $s1        #load in a1
	jal random_in_range  #call randominrange function
	move $s2, $v0		 #s2 = a
	#b = random_in_range(1,10000);
	move $a0, $s0        #load in a0
	move $a1, $s1        #load in a1
	jal random_in_range  #call randominrange function
	move $s3, $v0		 #s3 = b

	#gonna do gcd(a,b)
	move $a0, $s1        #load a in a0
	move $a1, $s2        #load b in a1
	jal gcd			     #call gcd
	move $s3, $v0		 #s3 = gcd(a,b)
	#printf("GCD(%d,%d) = %d\n", a, b, gcd(a, b));
	li $v0, 4		     #syscall code for print string
	la $a0, msg1	 	 #load string	
	syscall			     #printing "GCD("

	li $v0, 1		     #syscall code for printing int
	move $a0, $s6	     #load int
	syscall			     #print value of a

	li $v0, 4		     #syscall code for print string
	la $a0, msg2		 #load string
	syscall			     #printing ","

	li $v0, 1		     #syscall code for printing int
	move $a0, $s7		 #load int
	syscall			     #print value of b

	li $v0, 4		     #syscall code for print string
	la $a0, msg3	     #load string
	syscall			     #printing ") ="

	li $v0, 1		     #syscall code for printing int
	move $a0, $s5		 #load int
	syscall			     #print value of gcd

	li $v0 4		     #syscall code for print string
	la $a0, msg4		 #load string
	syscall			     #print new line

	addi $t0, 1		     #increase counter for for loop
	
	j loop

	finish:			     #end of loop
	li	$v0,10		     # exit
	syscall

	#gcd(a,b)
	gcd:
	#Pushing in to stack
	addi $sp,$sp,-4		# Adjust stack pointer
	sw $s0,0($sp)		# Save $s0
	addi $sp,$sp,-4		# Adjust stack pointer
	sw $s1,0($sp)		# Save $s1
	addi $sp,$sp,-4
	sw $ra,0($sp)

	move $s4, $a0		#s4 = a0 = a 
	move $s5, $a1		#s5 = a1 = b
	jal gcd_loop
	gcd_loop:
	beq $s5, $0, done
	div $s4, $s5
	move $s4, $s5
	mfhi $s5
	j gcd_loop
	done:
	move $v0, $s4
	#Poping from the stack
	lw $ra, 0($sp)
	addi $sp,$sp,4
	lw $s1,0($sp)		# Restore $s1
	addi $sp,$sp,4		# Adjust stack pointer
	lw $s0,0($sp)		# Restore $s0
	addi $sp,$sp,4		# Adjust stack pointer
	#Returning the value
	jr $ra

	random_in_range:
	#Pusing to the stack
	addi $sp,$sp,-4		# Adjust stack pointer
	sw $s0,0($sp)		# Save $s0
	addi $sp,$sp,-4		# Adjust stack pointer
	sw $s1,0($sp)		# Save $s1
	addi $sp,$sp,-4
	sw $ra,0($sp)
	#Make the random number in range
	move $s0, $a0 		#low
	move $s1, $a1		#high
	
	sub $s0, $s1, $s0	#high-low
	addi $s0, $s0, 1	#range = high-low+1

	jal	get_random	# Save current PC in $ra, and jump to get_random
	move	$s1,$v0		# Return value saved in $v0.move to $s1
	#(rand_num % range) + low;
	divu $s1, $s0		#divide the random num by range
	mfhi $s1		#move (rand_num % range) remainder to s1
	addi $s1, $s1, 1	#(rand_num % range) + low;

	move $v0, $s1		#move the result to be returned

	#Poping from the stack
	lw $ra,0($sp)
	addi $sp,$sp,4
	lw $s1,0($sp)		# Restore $s1
	addi $sp,$sp,4		# Adjust stack pointer
	lw $s0,0($sp)		# Restore $s0
	addi $sp,$sp,4		# Adjust stack pointer
		
	# Return from function
	jr $ra			# Jump to addr stored in $ra
	#function get_random that generate random 32-bit unsigned number
	get_random:
	#add to stack
	addi $sp,$sp,-4		# Adjust stack pointer
	sw $s0,0($sp)		# Save $s0
	addi $sp,$sp,-4		# Adjust stack pointer
	sw $s1,0($sp)
	addi $sp,$sp,-4
	sw $ra, 0($sp)		# Save $s1

	#Random number generator start
	li $t3, 36969
	li $t4, 18000
	li $t5, 65535

	lw $s0, m_z
	lw $s1, m_w

	and $t6, $s0, $t5	#(m_z & 65535)
	mul $t6, $t3, $t6	#36969 * (m_z & 65535)
	srl $t7, $s0, 16	#(m_z >> 16)
	addu $s0, $t6, $t7	#36969 * (m_z & 65535) + (m_z >> 16);
	sw $s0, m_z		# m_z = 36969 * (m_z & 65535) + (m_z >> 16)

	and $t6, $s1, $t5	#(m_w & 65535)
	mul $t6, $t4, $t6	#36969 * (m_w & 65535)
	srl $t7, $s1, 16	#(m_w >> 16)
	addu $s1, $t6, $t7	#18000 * (m_w & 65535) + (m_w >> 16);
	sw $s1, m_w		#m_w = 18000 * (m_w & 65535) + (m_w >> 16);

	sll $t6, $s0, 16	#(m_z << 16)
	addu $t6, $t6, $s1	#(m_z << 16) + m_w;

	move $v0, $t6

	#pop from stack
	lw $ra,0($sp)
	addi $sp,$sp,4
	lw $s1,0($sp)		# Restore $s1
	addi $sp,$sp,4		# Adjust stack pointer
	lw $s0,0($sp)		# Restore $s0
	addi $sp,$sp,4		# Adjust stack pointer
	
	# Return from function
	jr $ra			# Jump to addr stored in $ra

.data
m_w: .word 50000
m_z: .word 60000
msg1: .asciiz "GCD("
msg2: .asciiz ","
msg3: .asciiz ") ="
msg4: .asciiz "\n"


