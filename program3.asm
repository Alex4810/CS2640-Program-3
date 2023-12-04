.data
scores: .word 32, 56, 78, 66, 88, 90, 93, 100, 101, 82
fileName: .space 50  # Allocate space for filename input
filename_msg: .asciiz "Enter the filename (e.g., practiceFile.txt): "
practiceFile: .asciiz "practiceFile.txt"
enjoyMsg: .asciiz "What did u enjoy most in class: " 
aBuffer: .space 1025
bBuffer: .space 1025
userInput: .space 1025
test_msg: .asciiz "\nthis is a test message"

.text
main:
    # Task 1: Calculate Letter Grades


#task 2:
	#opens practice file
	li $v0, 13
	la $a0, practiceFile
	li $a1, 0
	li $a2, 0
	syscall
	move $s0, $v0
	
	#reads practice file
	li $v0, 14
	move $a0, $s0
	la $a1, aBuffer
	li $a2, 1024
	syscall
	
	#closes practice file
	li $v0, 16
	move $a0, $s0
	syscall
	
	# Print the contents of the buffer.
	#li $v0, 4
	#la $a0, aBuffer
	#syscall
	
#task 3
	#asks user for filename
	li $v0, 4
	la $a0, filename_msg
	syscall
	
	#stores file name
	la $a0, fileName
	li $a1, 49
	li $v0, 8
	syscall
	
	li $v0, 4
	syscall
	
	#opens test file
	li $v0, 13
	la $a0, fileName
	li $a1, 9
	li $a2, 0
	syscall
	move $s1, $v0
	
	#prints mesg
	li $v0, 4
	la $a0, enjoyMsg
	syscall
	
	#stores userinput
	la $a0, userInput
	li $a1, 1024
	li $v0, 8
	syscall
	
	#writes this is a test message to test file
	li $v0, 15
	move $a0, $s1
	la $a1, userInput
	li $a2, 1024
	syscall
	
	#closes practice file
	li $v0, 16
	move $a0, $s0
	syscall
	
#stops assembly
li $v0, 10
syscall
