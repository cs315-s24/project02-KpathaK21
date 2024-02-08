.global sort_s


# Function to find the index of the maximum value in the array
find_max_index_s:
	addi    sp, sp, -8
    sw      ra, 4(sp)
    sw      s0, 0(sp)

    mv      s0, a0          # s0 = pointer to array
    li      t0, 0           # t0 = index, initially 0
    lw      t1, 0(s0)       # Load the first element into t1 as max_value

loop:
    lw      t2, 0(s0)       # Load the current element into t2
    beq     t2, x0, done    # If current element is zero, exit loop
    bge     t2, t1, update  # If current element >= max_value, update max_value and max_index
    addi    t0, t0, 1       # Increment index

update:
    mv      t1, t2          # Update max_value
    addi    s0, s0, 4       # Move to the next element
    j       loop             # Continue loop

done:
    mv      a0, t0          # Return max_index

    lw      ra, 4(sp)
    lw      s0, 0(sp)
    addi    sp, sp, 8
    ret

# Function to sort the array in descending order
sort_s:
    addi    sp, sp, -16
    sw      ra, 12(sp)
    sw      s0, 8(sp)
    sw      s1, 4(sp)
    sw      s2, 0(sp)

    mv      s0, a0          # s0 = pointer to array
    mv      s1, a1          # s1 = length of the array
    li      t0, 0           # t0 = current index, initially 0

outer_loop:
    bge     t0, s1, end_outer # If current index >= length of the array, end outer loop

    # Find the index of the maximum value in the unsorted part of the array
    mv      a0, s0          # Load arguments
    add     a1, s1, x0      # Load arguments
    jal     find_max_index_s
    mv      s2, a0          # s2 = index of the maximum value in the unsorted part of the array

    # Calculate the addresses for swapping
        add     t5, s0, t0      # Address for current index
        add     t6, s0, s2      # Address for maximum value index
        

    # Swap the maximum value with the value at the current index
    lw      t3, 0(t5)       # Load the value at the current index
        lw      t4, 0(t6)       # Load the maximum value
        sw      t4, 0(t5)       # Store the maximum value at the current index
        sw      t3, 0(t6)       # Store the value from the current index at the position of the maximum value
    
    

    addi    t0, t0, 1       # Increment current index
    j       outer_loop      # Continue outer loop

end_outer:
    lw      ra, 12(sp)
    lw      s0, 8(sp)
    lw      s1, 4(sp)
    lw      s2, 0(sp)
    addi    sp, sp, 16
    ret
