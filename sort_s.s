.global sort_s

# Function to perform descending order sort
sort_s:
    addi sp, sp, -32   # Adjust stack pointer
    sd ra, 0(sp)       # Save return address
    sd a4, 8(sp)       # Save a4
    sd a6, 16(sp)      # Save a6
    sd t0, 24(sp)      # Save t0

    mv a4, a0          # Copy a0 to a4
    mv a6, a1          # Copy a1 to a6

    li t0, 0           # Initialize loop counter t0 to 0
outer_loop:
    blt t0, a6, end_outer_loop  # Exit outer loop if t0 >= a6

    # Call find_max_index_s
    mv a0, a4          # Pass array address
    mv a1, a6          # Pass array length
    jal find_max_index_s
    mv t1, a0          # Get the index of maximum element

    # Swap the maximum element with the element at index t0 if needed
    mv a0, a4          # Pass array address
    mv a1, t0          # Pass index of current element
    mv a2, t1          # Pass index of maximum element
    bge a1, a2, no_swap  # If current element is greater or equal, no need to swap
    jal swap_elements_s


no_swap:
    addi t0, t0, 1              # Increment outer loop counter
    j outer_loop                # Continue outer loop

end_outer_loop:
    ld ra, 0(sp)                # Restore return address
    ld a4, 8(sp)                # Restore a4
    ld a6, 16(sp)               # Restore a6
    ld t0, 24(sp)               # Restore t0
    addi sp, sp, 32             # Restore stack pointer
    ret                          # Return
# Function to find the index of the maximum element in an array
find_max_index_s:
    # Check if the array length is zero
    beqz a1, end_find_max_index
    
    # Initialize the index of the maximum element to -1
    li t0, -1          # Initialize index to 0
    lw t1, 0(a0)      # Load the first element into t1 as max_value
       
    # Loop through the array to find the maximum element
    li t3, 0          # Start loop counter from 0

loop_find_max_index:
    # Multiply loop counter by 4 (each element is 4 bytes)
    li t4, 4
    mul t4, t4, t3

    # Calculate the address of the current element in the array
    add t4, t4, a0     # Calculate address: array_base_address + loop_counter * element_size

    # Load the current element into t2
    lw t2, 0(t4)       # Load current element

    # Compare the current element with the maximum element
    bgt t2, t1, update_max_find_max_index

not_update_max_find_max_index:
    # Increment loop counter and continue loop
    addi t3, t3, 1
    blt t3, a1, loop_find_max_index   # Continue loop if loop counter < array length
    j end_loop_find_max_index         # Jump to end_loop if loop counter >= array length

update_max_find_max_index:
    # Update the index of the maximum element and the maximum element itself
    mv t0, t3
    mv t1, t2
    j not_update_max_find_max_index   # Continue loop

end_loop_find_max_index:
    # Return the index of the maximum element in a0
    mv a0, t0
    ret

end_find_max_index:
    # If the array length is zero, return -1 to indicate no maximum found
    li a0, -1
    ret

# Function to swap two elements in an array given their indices
swap_elements_s:
    # Calculate the addresses of the elements to swap
    slli t2, a1, 2              # Multiply index by 4 (each element is 4 bytes)
    slli t3, a2, 2              # Multiply index by 4 (each element is 4 bytes)
    add  t2, a0, t2             # Address of the first element
    add  t3, a0, t3             # Address of the second element

    lw t4, 0(t2)                # Load the first element
    lw t5, 0(t3)                # Load the second element

    # Swap the elements
    sw t5, 0(t2)                # Store the second element at the address of the first element
    sw t4, 0(t3)                # Store the first element at the address of the second element

    ret                         # Return
