.global to_upper_s



to_upper_s:
# Save the address of the input string
    mv a1, a0
    jal ra, to_upper   # Call the to_upper function

   # Print the modified string
        mv a0, a1          # Load the modified string address
        jal ra, print_string
       
    
        # Exit the program
        li a7, 93          # Syscall number for exit
        li a0, 0           # Exit code 0 for success
        ecall

# Function to convert a string to uppercase
to_upper:
    # Load the address of the input string
    mv a0, a1
    li t4, 100         # Max number of iterations to prevent infinite loop
    li t5, 0           # Initialize loop counter

loop:
    lbu t0, 0(a0)      # Load a byte from the string
    
    # Check if the byte is zero (end of string) or if max iterations reached, and exit loop if true
    beqz t0, end
    beq t5, t4, end

    # Check if the byte is a lowercase letter (a-z)
    li t1, 'a'         # Lower bound for lowercase letters
    li t2, 'z'         # Upper bound for lowercase letters
    blt t0, t1, not_lower
    bgt t0, t2, not_lower

    # Convert lowercase to uppercase by subtracting 32
    li t3, 'a' - 'A'   # Difference between lowercase and uppercase in ASCII
    sub t0, t0, t3

not_lower:
    sb t0, 0(a0)       # Store the modified byte back to the string
    
    # Move to the next byte in the string if not end of string
	beqz t0, end_loop
	addi a0, a0, 1
	j loop
end_loop:
	addi t5, t5, 1
	j loop
end:
    sb zero, 0(a0)     # Null-terminate the string
    ret

# Function to print a null-terminated string
print_string:
    mv a1, a0          # Load the string address into a1
loop_print:
    lbu a0, 0(a1)      # Load the next byte of the string
    beqz a0, end_print # Exit loop if null terminator is reached
    li a7, 93          # Syscall number for write
    li a2, 1           # Number of bytes to write
    li a1, 1           # File descriptor for stdout
    ecall
    addi a1, a1, 1     # Move to the next byte of the string
    j loop_print
end_print:
    ret
