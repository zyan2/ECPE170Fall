# Reads in an array of up to 256 characters
# searches the array to find if it contains the letter 'e'
# returns the address of where it found the first 'e'
# otherwise states that the array did not contain an 'e'

	# Declare main as a global function
	.globl main
	
	# All Program code is placed after the
	# .text assembler directive
	.text
	
# The label 'main' represents the starting point
main:
	# store values to be used for string and loops 
	la 	$t0, string	# place address of string in register t0, string pointer
	li 	$t1, 0		# place 0 in t1, this is i
	li 	$t2, 101	# place 101 in t2, decimal value of 'e'
	sw 	$zero, result	# result initiallized to NULL
	lw 	$t4, result	# place result in register t4
	
	
	# get input string from user and save
	li 	$v0, 8		# read string syscall code = 8
	la 	$a0, string	# syscall needs the starting address of string in a0
	li 	$a1, 256	# syscall needs length of string in a1
	syscall
	
	
	# loop to find if 'e' in string
loop:	add  	$t3, $t0, $t1	# find string[i]	
	lb   	$t6, 0($t3)	# load string[i] in t6
	beq  	$t6, $zero, next# branch if string[i] == NULL
	beq  	$t6, $t2, ise	# branch if string[i] == 'm'
	addi 	$t1, $t1, 1     # i++ 
	j    	loop		
	
	# 'e' was found in the string so set result = 'e'
ise:   sw  	 $t3, result	# store address of 'e' in result
	move	 $t4, $t3	# result in register = 'e'
	
	# if no 'e' found print no match, if 'e' found print address of 'e'
next:   beq  $t4, $zero, no_match # branch if result == NULL
	# Print msg2
	li   	$v0, 4		# print_string syscall code = 4
	la   	$a0, msg2	# put the msg2 pointer in to a0
	syscall
	# Print 'e' address
	li   	$v0, 1		# print_int syscall code = 1
	move	$a0, $t4	# put the address in to a0
	syscall
	# Print msg4
	li	$v0, 4 		# print_string syscall code = 4
	la	$a0, msg4	# put msg4 pointer in a0
	syscall
	# Print 'e' character
	li	$v0, 4		# print_string syscall code = 4
	move	$a0, $t4	# put the character to a0
	syscall
	j 	end
	# no 'e' found so print no match
no_match: 
	li   	$v0, 4 		# print_string syscall code = 4
	la   	$a0, msg3	# msg pointer must be in a0
	syscall
	
	# Exit the program by means of a syscall.
	# There are many syscalls - pick the desired one
	# by placing its code in $v0. The code for exit is "10"
end:	li   	$v0, 10 	# Sets $v0 to "10" to select exit syscall
	syscall 		# Exit

	# All memory structures are placed after the
	# .data assembler directive
	.data

	# The .word assembler directive reserves space
	# in memory for a single 4-byte word (or multiple 4-byte words)
	# and assigns that memory location an initial value
	# (or a comma separated list of initial values)
string: .space 256			# string is initially an empty 256 byte array
result: .space 8			# 8 bytes for the address of m
msg2:   .asciiz " First match at address " 
msg3:   .asciiz " No match found "
msg4:	.asciiz " The matching character is "

