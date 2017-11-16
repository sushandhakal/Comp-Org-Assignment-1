# The data section of the code
.data
	buffer: .space 9					# Storing the 
	outputMessage: .asciiz "The equivalent hexadecimal number is "
	errorMessage: .asciiz "Invalid hexadecimal number." 
	newLine: .asciiz "\n"					# A newline character
	
# The instruction section
.text
	main:
	# The main part of the program
		li $v0, 8		# Preparing the register for inputing the string
		la $a0, buffer	# Specifying what address to input the string to
		li $a1, 9		# Specifying the size of the input
		syscall			# Making the system call to input the string
			
		li $v0, 4		# Preparing the register to display a character
		la $a0, newLine		# loading the string newline into the argument dictionary
		syscall
				
		la $t1, buffer
		lb $t0, ($t1)
		beq $t0, 10, incorrectEnter
		
		li $s0, 0		# Register to store the converted integer value
		li $t4, 0		# The power of the hexadecimal number
		li $t0, 8		# Counter for the while
		li $t8, 0
	while:
		lb $t2, ($t1)		# Loading the first byte $t1 is pointing to
		beq $t2, 32, skip
		li $t8, 1
		# Preparing the arguments and calling the fucntion characCheck
		la $a0, ($t2)		# Passing the argument
		jal characCheck		# Calling the function
		beq $v0, 0, incorrectEnter		# If the condition doesn't satisfy we go to the end of the program
		
		# converting the character to integer
		la $a1, ($t2) 		# loading the arguements
		jal convChartoInteger	# callilng the function to call the argument
		la $t5, ($v1)		# loading the return value into thhe $t5
		
		sll $s0, $s0, 4
		addu $s0, $s0, $t5
		
		skip:
		addu $t1, $t1, 1		# Adding one to the value
		subi $t0, $t0, 1 	# Decreasing the counter value
		beq $t0, 0, exitWhile	# If the value in $t0 is equal to 0 exit the while
		b while			# Continue the while
	exitWhile:
		beq $t8, 0, incorrectEnter
		li $t0, 10
		divu $s0, $t0
		mflo $s0
		mfhi $s1
		
		li $v0, 1
		la $a0, ($s0)
		syscall
		
		li $v0, 1
		la $a0, ($s1)
		syscall
		
		li $v0, 10
		syscall
			
	incorrectEnter:
		li $v0, 4
		la $a0,	errorMessage
		syscall
			
		li $v0, 10		# Preparing the register to exit
		syscall			# Making the exit call


	characCheck:
			li $v0, 0
			beq $a0, 97, else
			beq $a0, 98, else
			beq $a0, 99, else
			beq $a0, 100, else
			beq $a0, 101, else
			beq $a0, 102, else
			beq $a0, 65, else
			beq $a0, 66, else
			beq $a0, 67, else
			beq $a0, 68, else
			beq $a0, 69, else
			beq $a0, 70, else
			beq $a0, 48, else
			beq $a0, 49, else
			beq $a0, 50, else
			beq $a0, 51, else
			beq $a0, 52, else
			beq $a0, 53, else
			beq $a0, 54, else
			beq $a0, 55, else
			beq $a0, 56, else
			beq $a0, 57, else
			jr $ra
		else:
			li $v0, 1
			jr $ra
						# going back to the original address


	convChartoInteger:
		slti $t8, $a1, 59
		beq $t8, 1, numbers
		
		slti $t8, $a1, 71
		beq $t8, 1, capital
		
		slti $t8, $a1, 103
		beq $t8, 1, small
		
		numbers:
			subi $v1, $a1, 48
			b exitConvChartoInteger 
		capital:
			subi $v1, $a1, 55
			b exitConvChartoInteger 
		small:
			subi $v1, $a1, 87
			b exitConvChartoInteger 
		exitConvChartoInteger:
			jr $ra
