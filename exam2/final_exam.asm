# A demonstration of some simple MIPS instructions
# used to test QtSPIM
#sum is t5 which is 28
	# Declare main as a global function
	.globl main 

	# All program code is placed after the
	# .text assembler directive
	.text 		

main:
	lw $t5, sum         #sum is 0
	li $s0, 5   #arraysize = s0 = 5
	li $t6, 0           #the counter is 0        
	la $t3, list        #put the address of list in t3
	li $t2, 1           #put the index into t2
	li $t7, 1           #put another index into t7
	
	j loop
loop:
	move $t7, $t2
	add $t7, $t7, $t7    # double the index
        add $t7, $t7, $t7    # double the index again (now 4x)
        add $t1, $t7, $t3    # combine the two components of the address
	lw $t4,0($t1)   #get the value from the array cell
	
	li $v0, 4		#syscall code for print string
	la $a0, msg1		#"array"
	syscall			#printing string
	
	li $v0, 1		#syscall code for print int
	move $a0,$t2      	 #number
	syscall         	#print number
	
	li $v0, 4		#syscall code for print string
	la $a0, msg3		#" = "
	syscall	
	
	li $v0, 1		#syscall code for print int
	move $a0,$t4      	 #number
	syscall         	#print number
	
	beq $t6, $s0, next1
	add $t6, $t6, 1        #counter +1
	add $t2, $t2, 1        #index +1
	j loop
next1:
	li $t2, 0            #index = 1;
	li $t6, 0        #the counter is 0 
	j arraySum

arraySum:
	move $t7,$t2       
	add $t7, $t7, $t7    # double the index
        add $t7, $t7, $t7    # double the index again (now 4x)
        add $t1, $t7, $t3    # combine the two components of the address
	lw $t4,0($t1)        #get the value from the array cell

	add $t5,$t5,$t4      #sum = sum + num
	beq $t6, 5, next2   #exit when counter = 5
	add $t6, $t6, 1        #counyer +1
	add $t2, $t2, 1        #index +1
	j arraySum
next2:
	li $v0, 4	#syscall code for print string
	la $a0, msg2	#"sum of Array is"
	syscall		#printing string




	.data
arraysize: .word 5
sum: .word 0
msg1: .asciiz "Array:"
msg2: .asciiz "sum of Array is "
msg3: .asciiz " = "
list: .word 2, 3, 5, 7, 11



