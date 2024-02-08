.global find_max_index_s

find_max_index_s:
   addi    sp, sp, -8
    sw      ra, 4(sp)
    sw      s0, 0(sp)

    mv      s0, a0          # s0 = pointer to array
    li      t0, 0           # t0 = index, initially 0
    lw      t1, 0(s0)       # Load the first element into t1 as max_value

loop:
    lw      t2, 0(s0)       # Load the current element into t2
    bge     t2, t1, update  # If current element >= max_value, update max_value and max_index
    addi    t0, t0, 1       # Increment index

update:
    mv      t1, t2          # Update max_value
    addi    s0, s0, 4       # Move to the next element
    addi    t0, t0, 1       # Increment index
    blt     t0, s1, loop    # Continue loop if index < length of the array

    mv      a0, t0          # Return max_index

    lw      ra, 4(sp)
    lw      s0, 0(sp)
    addi    sp, sp, 8
    ret


