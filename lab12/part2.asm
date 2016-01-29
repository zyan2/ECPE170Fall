# A demonstration of some simple MIPS instructions
# used to test QtSPIM

	# Declare main as a global function
	.globl main 

	# All program code is placed after the
	# .text assembler directive
	.text 		

main:
	la $s0, ArrayA    #initialize the array
	li $t0, 0         #initialize i =0
	li $t1, 0         #initialize j = 0
	j loop1
loop1:                 
    la $s0, msg16       # ArrayA[i][j] = '.';
	addi $s0,$s0,4      # move ArrayA[i][j+1]
	beq $t0, 54, loop2   # leave the loop and go to next step
	addi $t0, $t0, 4    
	j loop1

loop2:
	addi $s0,$s0,-4      # move ArrayA[i][j-1]
	beq $t1, 54, next   # leave the loop and go to next step
	addi $t1, $t1, 4    
	j loop12
next:
	la $s0, msg13       #ArrayA[0][0] = 'C';
	addi $s0, $s0, 32   #move to ArrayA[0][8]

	la $s0, msg13       #ArrayA[0][0] = 'C';
	addi $s0, $s0, 4    #move to ArrayA[1][0]

	la $s0, msg15       #ArrayA[1][0] = 'H';
	addi $s0, $s0, 32   #move to ArrayA[1][8]

	la $s0, msg15       #ArrayA[1][8] = 'H';
	addi $s0, $s0, 4    #move to ArrayA[2][0]

	la $s0, msg13       #ArrayA[2][0] = 'C';
	addi $s0, $s0, 32   #move to ArrayA[3][8]

	la $s0, msg13       #ArrayA[2][8] = 'C';
	addi $s0, $s0, 4    #move to ArrayA[4][0]

	la $s0, msg15       #ArrayA[3][0] = 'H';
	addi $s0, $s0, 32   #move to ArrayA[4][8]

	la $s0, msg15       #ArrayA[3][8] = 'H';
	addi $s0, $s0, 4    #move to ArrayA[5][0]


	#printf("Enter two positive numbers to initialize the random number generator.#\n";
   # printf("Please input first number for random number generation");

	li $v0, 4		#syscall code for print string
	la $a0, msg1	#"Welcome to Connect Four, Five-in-a-Row variant!"
	syscall			#printing string
	
	li $v0, 4		#syscall code for print string
	la $a0, msg5	#"\n"	
	syscall			#printing new line
	
	li $v0, 4		#syscall code for print string
	la $a0, msg2	#"Version 1.0"
	syscall			#printing string
	
	li $v0, 4		#syscall code for print string
	la $a0, msg5	#"\n"	
	syscall			#printing new line
	
	li $v0, 4		#syscall code for print string
	la $a0, msg3	# "Implemented by Zhiyun Yan"	
	syscall			#printing string
	
	li $v0, 4		#syscall code for print string
	la $a0, msg5	#"\n"
	syscall			#printing new line
	
	
	
	
	la 	$s1, m_z	# place address of the first seeds in register s0
	la	$s2, m_w	# place address of the second seeds in register s1
	li   $v0, 4		# print_string syscall code = 4
	la   $a0, msg6	# put the msg1 pointer in to a0
	syscall
	
	# get input int from user and save
	li 	$v0, 5		# read int syscall code = 5
	la 	$a0, m_z	 
	syscall
	
	li   	$v0, 4		# print_string syscall code = 4
	la   	$a0, msg7	
	syscall
	
	li	$v0, 5		# read int syscall code = 5
	la 	$a0, m_w	
	syscall
	
	j flip_coin		#call flip_coin function

	#flip_coin function
flip_coin:
	jal	get_random	# Save current PC in $ra, and to get_random
	move	$s5,$v0		# Return value saved in $v0.move to $s1
	#(rand_num % 2)
	li $t5, 2
	div $s1, $t5		#divide the random num by range
	mfhi $s5		#move (rand_num % range) remainder to s1


	
	beq $s5, 0, PcFirst
	beq $s5, 1, Humangofirst

PcFirst:
	jal printArrayA
	li   	$v0, 4		# print_string syscall code = 4
	la   	$a0, msg17	# put the msg1 pointer in to a0
	syscall
	j ComputerMove
ComputerMove:
	
	jal checkwin
	move $t9, $v0
	beq $t9, 1, humanwin
	beq $t9, 2, PCwin
	j ComputerMove
ComputerMove:
	jal generateRandomMove
	jal printArrayA
	li   	$v0, 4		# print_string syscall code = 4
	la   	$a0, msg15	# put the msg1 pointer in to a0
	syscall
	li 	$v0, 5		# read int syscall code = 5
	la 	$a0, user_in	# syscall needs the starting address of string in a0
	syscall
	jal userMove
	j ComputerMove
Humangofirst:
	jal printArrayA
	li   	$v0, 4		# print_string syscall code = 4
	la   	$a0, msg18	# put the msg1 pointer in to a0
	syscall
	j HumanMove
	
HumanMove:
	jal checkwin
	move $t9, $v0
	beq $t9, 1, humanwin
	beq $t9, 2, PCwin
	j HumanMove_game
HumanMove_game:
	li   	$v0, 4		# print_string syscall code = 4
	la   	$a0, msg20	# put the msg1 pointer in to a0
	syscall
	li 	$v0, 5		# read int syscall code = 5
	la 	$a0, user_in	# syscall needs the starting address of string in a0
	syscall
	jal userMove
	jal printArrayA
	jal generateRandomMove
	j HumanMove
humanwin:
	jal printArrayA
	li   	$v0, 4		# print_string syscall code = 4
	la   	$a0, msg11	# put the msg1 pointer in to a0
	syscall
	li	$v0,10		# exit
	syscall
PCwin:
	jal printArrayA
	li   	$v0, 4		# print_string syscall code = 4
	la   	$a0, msg10	# put the msg1 pointer in to a0
	syscall
	li	$v0,10		# exit
	syscall
	get_random:

	addi $sp,$sp,-4		# Adjust stack pointer
	sw $s0,0($sp)		# Save $s0
	addi $sp,$sp,-4		# Adjust stack pointer
	sw $s1,0($sp)		# Save $s1
	addi $sp,$sp,-4
	sw $ra,0($sp)

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
	#Poping from the stack
	lw $ra, 0($sp)
	addi $sp,$sp,4
	lw $s1,0($sp)		# Restore $s1
	addi $sp,$sp,4		# Adjust stack pointer
	lw $s0,0($sp)		# Restore $s0
	addi $sp,$sp,4		# Adjust stack pointer
	
	# Return from function
	jr $ra		
	
printArrayA:
	addi $sp,$sp,-4		# Adjust stack pointer
	sw $s0,0($sp)		# Save $s0
	addi $sp,$sp,-4		# Adjust stack pointer
	sw $s1,0($sp)		# Save $s1
	addi $sp,$sp,-4
	sw $ra,0($sp)
	
	li $v0, 4		#syscall code for print string
	la $a0, msg5	#"/n"	
	syscall			#printing new line
	
	li $v0, 4		#syscall code for print string
	la $a0, msg17	#load string	
	syscall			#printing string
	
	li $v0, 4		#syscall code for print string
	la $a0, msg5	#"\n"
	syscall			#printing new line
	
	li $v0, 4		#syscall code for print string
	la $a0, msg14	#"-------"	
	syscall			#printing string
	
	li $t2, 0		#counter for outer loop
	la $t0, board 		#initialize pointer to start of array board
	
	j draw_loop1
	
draw_loop1:	
	move $t3,$t0 # Initialize col. pointer to 1st element of row
	beq $t2, 6, drawEnd	#go to drawEnd if loop is done
	li $v0, 4		#syscall code for print string
	la $a0, msg5		#load string	
	syscall			#printing new line
	li $t4, 0		#counter for inner loop
	j draw_loop2
	
draw_loop2:
	li $t7, 0		#load value 0 in $t7
	li $t8, 2		#load value 2 in $t8
	li $t9, 1		#load value 1 in $t9
	beq $t4, 9 drawInnerEnd
	lw $t6,0($t3)
	beq $t6, $t7, equal0
	beq $t6, $t8, equal2
	beq $t6, $t9, equal1
	
equal0:
	li $v0, 4		#syscall code for print string
	la $a0, msg10		#load string	
	syscall			#printing string
	addi $t4, 1		#increment counter
	addi $t3,$t3, 4 	#increment the column pointer 
	j draw_loop2

equal2:
	li $v0, 4		#syscall code for print string
	la $a0, msg11		#load string	
	syscall			#printing string
	addi $t4, 1		#increment counter
	addi $t3,$t3, 4 	#increment the column pointer 
	j draw_loop2
	
equal1:
	li $v0, 4		#syscall code for print string
	la $a0, msg12		#load string	
	syscall			#printing string
	addi $t4, 1		#increment counter
	addi $t3,$t3, 4 	#increment the column pointer
	j draw_loop2	
	
drawInnerEnd:
	addi $t0, $t0, 36
	addi $t2, $t2, 1
	j draw_loop1
	
drawEnd:
	li $v0, 4		#syscall code for print string
	la $a0, msg5		#load string	
	syscall			#printing new line
	
	li $v0, 4		#syscall code for print string
	la $a0, msg9		#load string	
	syscall			#printing string
	
	li $v0, 4		#syscall code for print string
	la $a0, msg5		#load string	
	syscall			#printing new line
	
	#Poping from the stack
	lw $ra, 0($sp)
	addi $sp,$sp,4
	lw $s1,0($sp)		# Restore $s1
	addi $sp,$sp,4		# Adjust stack pointer
	lw $s0,0($sp)		# Restore $s0
	addi $sp,$sp,4		# Adjust stack pointer
	
	jr $ra
checkIfEmpty:
	move $t8, $a0
	move $t7, $a1
	mul $t6, $t8, 36
	mul $t5, $t7, 4
	add $t6, $t6, $t5
	lw $s5,0($t6)
	beq $s5, 2, empty
	j notEmpty
empty:
	li $t3, 1
	move $v0, $t3
	lw $ra, 0($sp)
	addi $sp,$sp,4
	lw $s1,0($sp)		# Restore $s1
	addi $sp,$sp,4		# Adjust stack pointer
	lw $s0,0($sp)		# Restore $s0
	addi $sp,$sp,4		# Adjust stack pointer
	jr $ra
notEmpty:
	li $t3, 2
	move $v0, $t3
	lw $ra, 0($sp)
	addi $sp,$sp,4
	lw $s1,0($sp)		# Restore $s1
	addi $sp,$sp,4		# Adjust stack pointer
	lw $s0,0($sp)		# Restore $s0
	addi $sp,$sp,4		# Adjust stack pointer
	jr $ra

#genearteRandomMove function	
generateRandomMove:
	#Pushing in to stack
	addi $sp,$sp,-4		# Adjust stack pointer
	sw $s0,0($sp)		# Save $s0
	addi $sp,$sp,-4		# Adjust stack pointer
	sw $s1,0($sp)		# Save $s1
	addi $sp,$sp,-4
	sw $ra,0($sp)

	li $s7, 5		#counter i=5
	li $s6, 7
	jal	get_random	
	move	$s1,$v0		# Return value saved in $v0.move to $t1
	div $s1, $s6		#divide the random num by 7
	mfhi $s3		#move (rand_num % 7) remainder to s1
	addi $s3, 1
	j generateRandomMove2
generateRandomMove2:
	move $a0, $s7
	move $a1, $s3
	jal checkIfEmpty
	move $s1, $v0
	beq $s1, 1, makeMove
	j goNextRow
goNextRow:
	addi $s7, -1
	bgt $0, $s7, generateRandomMove
	j generateRandomMove2

makeMove:
	li $t9, 1
	mul $t6, $s7, 36
	mul $t5, $s3, 4
	add $t6, $t6, $t5
	sw $t9,0($t6) # Store value in current array element
	
	#Poping from the stack
	lw $ra, 0($sp)
	addi $sp,$sp,4
	lw $s1,0($sp)		# Restore $s1
	addi $sp,$sp,4		# Adjust stack pointer
	lw $s0,0($sp)		# Restore $s0
	addi $sp,$sp,4		# Adjust stack pointer
	jr $ra
userMove:
	#Pushing in to stack
	addi $sp,$sp,-4		# Adjust stack pointer
	sw $s0,0($sp)		# Save $s0
	addi $sp,$sp,-4		# Adjust stack pointer
	sw $s1,0($sp)		# Save $s1
	addi $sp,$sp,-4
	sw $ra,0($sp)

	move $s3, $a0
	li $s4, 5
	j userMove2
userMove2:
	move $a0, $s4
	move $a1, $s3
	jal checkIfEmpty
	move $t1, $v0
	beq $t1, 1, makeUserMove
	j userNextRow
userNextRow:
	addi $s4, -1
	j userMove2
	
makeUserMove:
	li $t9, 0
	mul $t6, $s4, 36
	mul $t5, $s3, 4
	add $t6, $t6, $t5
	sw $t9,0($t6) # Store value in current array element
	
	#Poping from the stack
	lw $ra, 0($sp)
	addi $sp,$sp,4
	lw $s1,0($sp)		# Restore $s1
	addi $sp,$sp,4		# Adjust stack pointer
	lw $s0,0($sp)		# Restore $s0
	addi $sp,$sp,4		# Adjust stack pointer
	
	jr $ra
#my checkFive function
checkwin:
	addi $sp,$sp,-4		# Adjust stack pointer
	sw $s0,0($sp)		# Save $s0
	addi $sp,$sp,-4		# Adjust stack pointer
	sw $s1,0($sp)		# Save $s1
	addi $sp,$sp,-4
	sw $ra,0($sp)
	li $t2, 0		#counter for outer loop
	la $t0, board		#initialize pointer to start of array board
	j checkFive
checkFive:
	move $t3,$t0 # Initialize col. pointer to 1st element of row
	beq $t2, 6, fiveEnd	#go to fiveEnd if loop is done
	li $t4, 0		#counter for inner loop
	j five_loop
	
five_loop:
	li $t7, 0		#load value 0 in $t7
	li $t8, 2		#load value 2 in $t8
	li $t9, 1		#load value 1 in $t9
	beq $t4, 9, fiveInnerEnd
	j check1

fiveInnerEnd:
	addi $t0, $t0, 36
	addi $t2, $t2, 1
	j checkFive
fiveEnd:
	move $v0, $t7
	
	#Poping from the stack
	lw $ra, 0($sp)
	addi $sp,$sp,4
	lw $s1,0($sp)		# Restore $s1
	addi $sp,$sp,4		# Adjust stack pointer
	lw $s0,0($sp)		# Restore $s0
	addi $sp,$sp,4		# Adjust stack pointer
	jr $ra
	
	
check1:
	lw $s6,0($t3)
	li $t1, 5
	bgt $t1, $t4, horz_check
	j check2
	
check2:
	move $t3,$t0
	li $t1, 2
	bgt $t1, $t2, vert_check
	j check3

check3:
	move $t3,$t0
	li $t1, 5
	bgt $t1, $t4, diag1_check
	j check4

check4:
	move $t3,$t0
	bgt $t4, 3, diag2_check
	j endOfCheck
#diagonal checks	
diag2_check:
	li $t1,2
	bgt $t1, $t2, diag2_check2
	j endOfCheck
	
diag2_check2:
	beq $s6, $t7, diag2_human1
	beq $s6, $t9, diag2_computer1
	j endOfCheck
	
diag2_computer1:
	addi $t3, $t3, 32
	lw $s6,0($t3)
	beq $s6, $t9, diag2_computer2
	j endOfCheck
diag2_computer2:
	addi $t3, $t3, 32
	lw $s6,0($t3)
	beq $s6, $t9, diag2_computer3
	j endOfCheck
diag2_computer3:
	addi $t3, $t3, 32
	lw $s6,0($t3)
	beq $s6, $t9, diag2_computer4
	j endOfCheck
diag2_computer4:
	addi $t3, $t3, 32
	lw $s6,0($t3)
	beq $s6, $t9, ComputerWin
	j endOfCheck

diag2_human1:
	addi $t3, $t3, 32
	lw $s6,0($t3)
	beq $s6, $t7, diag2_human2
	j endOfCheck
diag2_human2:
	addi $t3, $t3, 32
	lw $s6,0($t3)
	beq $s6, $t7, diag2_human3
	j endOfCheck
diag2_human3:
	addi $t3, $t3, 32
	lw $s6,0($t3)
	beq $s6, $t7, diag2_human4
	j endOfCheck
diag2_human4:
	addi $t3, $t3, 32
	lw $s6,0($t3)
	beq $s6, $t7, HumanWin
	j endOfCheck
	
	
diag1_check:
	li $t1,2
	bgt $t1, $t2, diag1_check2
	j check4
	
diag1_check2:
	beq $s6, $t7, diag1_human1
	beq $s6, $t9, diag1_computer1
	j check4
diag1_computer1:
	addi $t3, $t3, 40
	lw $s6,0($t3)
	beq $s6, $t9, diag1_computer2
	j check4	
diag1_computer2:
	addi $t3, $t3, 40
	lw $s6,0($t3)
	beq $s6, $t9, diag1_computer3
	j check4	
diag1_computer3:
	addi $t3, $t3, 40
	lw $s6,0($t3)
	beq $s6, $t9, diag1_computer4
	j check4	
diag1_computer4:
	addi $t3, $t3, 40
	lw $s6,0($t3)
	beq $s6, $t9, ComputerWin
	j check4	
		
	
diag1_human1:
	addi $t3, $t3, 40
	lw $s6,0($t3)
	beq $s6, $t7, diag1_human2
	j check4
diag1_human2:
	addi $t3, $t3, 40
	lw $s6,0($t3)
	beq $s6, $t7, diag1_human3
	j check4
diag1_human3:
	addi $t3, $t3, 40
	lw $s6,0($t3)
	beq $s6, $t7, diag1_human4
	j check4
diag1_human4:
	addi $t3, $t3, 40
	lw $s6,0($t3)
	beq $s6, $t7, HumanWin
	j check4
#vertical checks
	
vert_check:
	beq $s6, $t7, vert_human1
	beq $s6, $t9, vert_computer1
	j check3
vert_computer1:
	addi $t3, $t3, 36
	lw $s6,0($t3)
	beq $s6, $t9, vert_computer2
	j check3
vert_computer2:
	addi $t3, $t3, 36
	lw $s6,0($t3)
	beq $s6, $t9, vert_computer3
	j check3
vert_computer3:
	addi $t3, $t3, 36
	lw $s6,0($t3)
	beq $s6, $t9, vert_computer4
	j check3
vert_computer4:
	addi $t3, $t3, 36
	lw $s6,0($t3)
	beq $s6, $t9, ComputerWin
	j check3
vert_human1:
	addi $t3, $t3, 36
	lw $s6,0($t3)
	beq $s6, $t7, vert_human2
	j check3
vert_human2:
	addi $t3, $t3, 36
	lw $s6,0($t3)
	beq $s6, $t7, vert_human3
	j check3
vert_human3:
	addi $t3, $t3, 36
	lw $s6,0($t3)
	beq $s6, $t7, vert_human4
	j check3
vert_human4:
	addi $t3, $t3, 36
	lw $s6,0($t3)
	beq $s6, $t7, HumanWin
	j check3
	
	
#hortizonal checks
horz_check:
	beq $s6, $t7, horz_human1
	beq $s6, $t9, horz_computer1
	j check2
horz_human1:
	addi $t3, $t3, 4
	lw $s6,0($t3)
	beq $s6, $t7, horz_human2
	j check2
horz_human2:
	addi $t3, $t3, 4
	lw $s6,0($t3)
	beq $s6, $t7, horz_human3
	j check2
horz_human3:
	addi $t3, $t3, 4
	lw $s6,0($t3)
	beq $s6, $t7, horz_human4
	j check2
horz_human4:
	addi $t3, $t3, 4
	lw $s6,0($t3)
	beq $s6, $t7, HumanWin
	j check2
horz_computer1:
	addi $t3, $t3, 4
	lw $s6,0($t3)
	beq $s6, $t9, horz_computer2
	j check2
horz_computer2:
	addi $t3, $t3, 4
	lw $s6,0($t3)
	beq $s6, $t9, horz_computer3
	j check2
horz_computer3:
	addi $t3, $t3, 4
	lw $s6,0($t3)
	beq $s6, $t9, horz_computer4
	j check2
horz_computer4:
	addi $t3, $t3, 4
	lw $s6,0($t3)
	beq $s6, $t9, ComputerWin
	j check2
#human win
HumanWin:

	move $v0, $t9
	lw $ra, 0($sp)
	addi $sp,$sp,4
	lw $s1,0($sp)		# Restore $s1
	addi $sp,$sp,4		# Adjust stack pointer
	lw $s0,0($sp)		# Restore $s0
	addi $sp,$sp,4		# Adjust stack pointer
	jr $ra
#computer win
ComputerWin:
	move $v0, $t8
	lw $ra, 0($sp)
	addi $sp,$sp,4
	lw $s1,0($sp)		# Restore $s1
	addi $sp,$sp,4		# Adjust stack pointer
	lw $s0,0($sp)		# Restore $s0
	addi $sp,$sp,4		# Adjust stack pointer
	jr $ra
#no one wins
endOfCheck:
	addi $t4, 1
	j five_loop
	
	





	.data
ArrayA: .space 216    #it is the place for ArrayA[6][9]
user_in: .word 0
m_w: .word 0
m_z: .word 0
msg1: .asciiz "Welcome to Connect Four, Five-in-a-Row variant!"
msg2: .asciiz "Version 1.0"
msg3: .asciiz "Implemented by Zhiyun Yan"
msg4: .asciiz "Enter two positive numbers to initialize the random number generator."
msg5: .asciiz "\n"
msg6: .asciiz "Please input first number for random number generation:"
msg7: .asciiz "Please input second number for random number generation:"
msg8: .asciiz "Coin Toss.. Computer goes first"
msg9: .asciiz "Coin Toss.. Human goes first"
msg10: .asciiz "Computer win"
msg11: .asciiz "Human win"
msg12: .asciiz "You cant do this"
msg13: .asciiz "C"
msg14: .asciiz "---------"
msg15: .asciiz "H"
msg16: .asciiz "."
msg17: .asciiz " 1234567"
msg18: .asciiz "Human goes first!\n"
msg19: .asciiz "Computer goes first!\n"
msg20: .asciiz "Input a column number to drop token in\n"

