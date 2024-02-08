.global to_upper_s

to_upper_s:
    # Save registers used for function call
    addi    sp, sp, -4
    sw      ra, 0(sp)
    
    # Define variables
    li      t0, 0        # t0: loop counter

loop:
    lb      t1, 0(a0)   # Load byte from memory
    beqz    t1, done     # If t1 == 0 (end of string), exit loop

    li      t2, 'a'     # Load ASCII value of 'a'
    li      t3, 'z'     # Load ASCII value of 'z'
    blt     t1, t2, next_char  # If t1 < 'a', skip lowercase conversion
    bge     t1, t3, next_char # If t1 >= 'z', skip lowercase conversion
    li      t4, 'A'     # Load ASCII value of 'A'
    xor    t1, t1, t4  # Convert lowercase to uppercase
    sb      t1, 0(a0)    # Store modified byte back to memory
next_char:
    addi    a0, a0, 1    # Move to the next character in the string
    j       loop          # Repeat loop
    
done:
    # Restore saved registers
    lw      ra, 0(sp)
    addi    sp, sp, 4
    
    # Return from function
    ret
