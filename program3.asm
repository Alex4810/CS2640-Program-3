.data
scores: .word 32, 56, 78, 66, 88, 90, 93, 100, 101, 82
fileName: .space 50  # Allocate space for filename input
filename_msg: .asciiz "Enter the filename (e.g., practiceFile.txt): "
practiceFile: .asciiz "practiceFile.txt"
enjoyMsg: .asciiz "What did you enjoy most in class: " 
aBuffer: .space 1025
bBuffer: .space 1025
userInput: .space 1025
test_msg: .asciiz "\nthis is a test message"
aString: .asciiz "A\n"
bString: .asciiz "B\n"
cString: .asciiz "C\n"
dString: .asciiz "D\n"
fString: .asciiz "F\n"
newline: .asciiz "\n"
.grades_label: .asciiz "The grade for "
.is_label: .asciiz " is: A with Extra Credit"
.is_label_A: .asciiz " is: A\n"
.is_label_B: .asciiz " is: B\n"
.is_label_C: .asciiz " is: C\n"
.is_label_D: .asciiz " is: D\n"
.is_label_F: .asciiz " is: F\n"



.text
# Task 1: Calculate Letter Grades
li $t0, 0       # loop counter
la $t1, scores  # pointer to scores array

grade_loop:
    lw $t2, 0($t1)   # load score

    # Your revised logic for grade calculation here
    bgt $t2, 100, print_A_with_extra_credit
    bgt $t2, 90, print_A
    bgt $t2, 80, print_B
    bgt $t2, 70, print_C
    bgt $t2, 60, print_D
    j print_F




print_A_with_extra_credit:
    li $v0, 4
    la $a0, .grades_label  # Load the address of the string "The grade for "
    syscall

    li $v0, 1
    move $a0, $t2
    syscall

    li $v0, 4
    la $a0, .is_label  # Load the address of the string " is: A with Extra Credit"
    syscall
    j next_iteration


print_A:
    li $v0, 4
    la $a0, .grades_label  # Load the address of the string "The grade for "
    syscall

    li $v0, 1
    move $a0, $t2
    syscall

    bgt $t2, 100, print_A_with_extra_credit
    li $v0, 4
    la $a0, .is_label_A  # Load the address of the string " is: A"
    syscall
    j next_iteration

print_B:
    li $v0, 4
    la $a0, .grades_label  # Load the address of the string "The grade for "
    syscall

    li $v0, 1
    move $a0, $t2
    syscall

    li $v0, 4
    la $a0, .is_label_B  # Load the address of the string " is: B"
    syscall
    j next_iteration

print_C:
    li $v0, 4
    la $a0, .grades_label  # Load the address of the string "The grade for "
    syscall

    li $v0, 1
    move $a0, $t2
    syscall

    li $v0, 4
    la $a0, .is_label_C  # Load the address of the string " is: C"
    syscall
    j next_iteration

print_D:
    li $v0, 4
    la $a0, .grades_label  # Load the address of the string "The grade for "
    syscall

    li $v0, 1
    move $a0, $t2
    syscall

    li $v0, 4
    la $a0, .is_label_D  # Load the address of the string " is: D"
    syscall
    j next_iteration

print_F:
    li $v0, 4
    la $a0, .grades_label  # Load the address of the string "The grade for "
    syscall

    li $v0, 1
    move $a0, $t2
    syscall

    li $v0, 4
    la $a0, .is_label_F  # Load the address of the string " is: F"
    syscall
    j next_iteration


next_iteration:
    addi $t0, $t0, 1      # Increment loop counter
    addi $t1, $t1, 4      # Move to the next element in the array

    # Check if we reached the end of the array
    li $t3, 10            # Number of elements in the array
    beq $t0, $t3, end_print  # Exit the loop if we processed all elements

    # Print a newline for better formatting
    li $v0, 4
li $v0, 4
la $a0, newline
syscall
    syscall

    j grade_loop

end_print:
    # Print your name
    li $v0, 4
    syscall

    # Exit program
    li $v0, 10
    syscall




# Task 2: File Operations (Read from practiceFile.txt)
    li $v0, 13
    la $a0, practiceFile
    li $a1, 0
    li $a2, 0
    syscall
    move $s0, $v0

    li $v0, 14
    move $a0, $s0
    la $a1, aBuffer
    li $a2, 1024
    syscall

    li $v0, 16
    move $a0, $s0
    syscall

# Task 3: File Operations (Append to a user-defined file)
    la $a0, filename_msg
    li $v0, 4
    syscall

    la $a0, fileName
    li $a1, 49
    li $v0, 8
    syscall

    li $v0, 13
    la $a0, fileName
    li $a1, 9
    li $a2, 0
    syscall
    move $s1, $v0

    li $v0, 4 
    la $a0, enjoyMsg
    syscall

    la $a0, userInput
    li $a1, 1024
    li $v0, 8
    syscall

    li $v0, 15
    move $a0, $s1
    la $a1, userInput
    li $a2, 1024
    syscall

    li $v0, 16
    move $a0, $s1
    syscall

# Exit program
    li $v0, 10
    syscall
