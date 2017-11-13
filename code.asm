data
	promptMessage: .asciiz "Enter string that is no more than 8 characters: "
	string: .space 9
.text
main:
	#prints the promptMessage
	li $v0, 4   
	la $a0, promptMessage
	syscall
	#gets the input from the user and stores it 
	li $v0, 8
	la $a0, string
	li $a1, 9
	syscall
	
	la $t0, string
	
	li $t2, 1
loopBegin:
	beq $t2, 8, loopEnd	# Setting the condition to set when the loop ends
	
	lb $t1, ($t0)		# Loading the character in $t0 into $t1

	# Perform some operation on the char to check if it satisfies the condition
	
	addu $t0, $t0, 1		# The $t0 register now points to the next character in the string
	addi $t2, $t2, 1	
	b loopBegin		# Jump to the beginng of the loop
loopEnd:
	
	#calls system to end program
	li $v0, 10
	syscall
