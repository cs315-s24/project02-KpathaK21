.global sort_s


find_max_index_s:
	 # Check if the array length is zero
    beqz a1, end
    
        # Initialize the index of the maximum element to -1
        li t0, 0          # Initialize index to 0
        lw t1, 0(a0)       # Load the first element into t1 as max_value
       
        # Loop through the array to find the maximum element
        li t3, 0         # Start loop counter from 0

loop:
    # Multiply loop counter by 4 (each element is 4 bytes)
    li t4, 4
    mul t4, t4, t3

    # Calculate the address of the current element in the array
    add t4, t4, a0     # Calculate address: array_base_address + loop_counter * element_size

    # Load the current element into t2
    lw t2, 0(t4)       # Load current element

    # Compare the current element with the maximum element
    bgt t2, t1, update_max


not_update_max:
    # Increment loop counter and continue loop
    addi t3, t3, 1
    blt t3, a1, loop   # Continue loop if loop counter < array length
    j end_loop         # Jump to end_loop if loop counter >= array length

update_max:
    # Update the index of the maximum element and the maximum element itself
    mv t0, t3
    mv t1, t2
    j not_update_max   # Continue loop

end_loop:
    # Return the index of the maximum element in a0
    mv a0, t0
    ret

end:
    # If the array length is zero, return -1 to indicate no maximum found
    li a0, -1
    ret

sort_s:
    # Check if the array length is zero
    beqz a1, end_sort
    
    # Loop through the array to sort
    li t3, 0         # Start loop counter from 0

outer_loop:
    # Check if loop counter >= array length
    bge t3, a1, end_sort

    # Call find_max_index_s to get the index of the maximum element
    jal ra, find_max_index_s
    mv t0, a0          # Move index of max element to t0

    # Load the maximum element into t1
    lw t1, 0(t0)       # Load max_value

    # Load the current element into t2
    add t4, a0, t3     # Calculate address of the current element
    lw t2, 0(t4)       # Load current element

    # Swap maximum element with the first element in the unsorted portion
    sw t2, 0(t0)       # Store current element where max_value was
    sw t1, 0(t4)       # Store max_value where current element was


    # Increment loop counter
    addi t3, t3, 1     # Increment loop counter
    j outer_loop       # Continue outer loop

end_sort:
    ret
    
