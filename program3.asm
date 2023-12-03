.data
scores: .word 32, 56, 78, 66, 88, 90, 93, 100, 101, 82
filename: .space 50  # Allocate space for filename input
filename_msg: .asciiz "\nEnter the filename (e.g., practiceFile.txt): "
grade_msg: .asciiz "\nYour Letter Grade: "
file_msg: .asciiz "\nThis is a practice file. Use it to practice Assembly programming\n- open file\n- close file\n- you could even practice writing to this file\nThis file will be used when testing your code submitted for Program 3."
question_msg: .asciiz "\nWhat have you enjoyed most about the class so far?"
success_msg: .asciiz "\nFile operation successful."
error_msg: .asciiz "\nError in file operation."
your_name: .asciiz "\nYour Name Here"  # Replace with your actual name

.text
main:
    # Task 1: Calculate Letter Grades
    li $t0, 0       # loop counter
    la $t1, scores  # pointer to scores array

    grade_loop:
        lw $t2, 0($t1)   # load score
        # Your logic for grade calculation here

        # Print the result
        li $v0, 4
        la $a0, grade_msg
        syscall

        li $v0, 1
        move $a0, $t2
        syscall

        # Move to the next score
        addi $t1, $t1, 4

        # Check if the loop counter has reached the end
        bge $t0, 10, file_operation

        # Increment the loop counter
        addi $t0, $t0, 1

        # Loop back
        j grade_loop

    file_operation:
        # Task 2: Open, Write, and Close File
        la $a0, filename_msg  # prompt for filename input
        li $v0, 4
        syscall

        # Read filename from user input
        li $v0, 8
        la $a0, filename
        li $a1, 50  # maximum filename length
        syscall

        # Open the file for append
        li $v0, 13       # syscall for open file
        la $a0, filename  # pointer to the filename
        li $a1, 1        # flags: append mode
        li $a2, 0        # mode: ignored for append
        syscall

        # Check if the file was opened successfully
        bge $v0, 0, file_append_success
        j file_append_error

    file_append_success:
        # Print success message
        li $v0, 4
        la $a0, success_msg
        syscall

        # Write the question to the file
        li $v0, 15        # syscall for write to file
        move $a0, $v0     # file descriptor
        la $a1, question_msg  # pointer to the message
        li $a2, 50        # length of the message
        syscall

        # Close the file
        li $v0, 16       # syscall for close file
        move $a0, $v0    # file descriptor
        syscall

        # Print your name
        li $v0, 4
        la $a0, your_name
        syscall

        # Exit program
        li $v0, 10
        syscall

    file_append_error:
        # Print error message
        li $v0, 4
        la $a0, error_msg
        syscall

        # Exit program
        li $v0, 10
        syscall
