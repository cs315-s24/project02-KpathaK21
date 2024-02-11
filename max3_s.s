.global max2_s
.global max3_s


# Define function max2_s
max2_s:
    # Compare a and b
    bge a0, a1, greater_than_or_equal
    # if (a < b), return b
    mv a0, a1
    ret

greater_than_or_equal:
    # if (a >= b), return a
    ret
    
# Define function max3_s
max3_s:
    # Allocate space on the stack for variables
    addi sp, sp, -8

    # Call max2_c for a and b
    call max2_c
    mv s0, a0   # Store the result of max2_c(a, b) in s0

    # Store first_two on the stack
    sw s0, 0(sp)

    # Move c to a1 register
    mv a1, a2

    # Load first_two from the stack
    lw a0, 0(sp)

    # Call max2_c for first_two and c
    call max2_c
    

    # Clean up the stack
    addi sp, sp, 8

    # Return the result
    mv a0,a0

    li a7, 1
    ecall

    ret
