.global max3_s
.global max2_s

max2_s:
    # Preserve return address
        addi    sp, sp, -4
        sw      ra, 0(sp)
    
        # Load arguments
        mv      t0, a0
        mv      t1, a1
    
        # Compare values
        blt     t0, t1, max2_s_end
    
        # If t2 > t3, return t2
        mv      a0, t0
        j       max2_s_exit
max2_s_end:
   # If t2 <= t3, return t3
   mv      a0, t1

max2_s_exit:
    # Restore return address
    lw      ra, 0(sp)
    addi    sp, sp, 4
    ret


max3_s:
   # Preserve return address
        addi    sp, sp, -8
        sw      ra, 0(sp)
    
        # Load arguments
         mv      t0, a0
    	 mv      t1, a1
    
        # Call max2_s for first comparison
        jal     max2_s


     # Store result of first comparison
    mv      a1, a0

    # Load the third parameter from stack pointer
    lw      a0, 8(sp)   # Assuming third parameter is at 8(sp) after the return address and two parameters

    # Call max2_s for second comparison
    jal     max2_s

    # Store result of second comparison
    mv      a2, a0

    # Restore return address
    lw      ra, 0(sp)
    addi    sp, sp, 8
    ret
