.global to_upper_s

to_upper_s:
    # Save the address of the input string
    mv t6, a0

    # Load the address of the input string
    mv a0, t6
   
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
    addi a0, a0, 1     # Move to the next byte in the string
    addi t5, t5, 1     # Increment loop counter
    j loop

end:
    ret
