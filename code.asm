.data
	promptMessage: .asciiz "Enter string that is no more than 8 characters: "
	string: .space 9
.text
	#prints the promptMessage
	li $v0, 4   
	la $a0, promptMessage
	syscall
	#gets the input from the user and stores it 
	li $v0, 8
	la $a0, string
	li $a1, 9
	syscall
	#calls system to end program
	li $v0, 10
	syscall 
