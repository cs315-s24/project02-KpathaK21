.global max2_s
.global max3_s

# Function to find maximum of two signed integers
# Arguments: a0 = first integer, a1 = second integer
# Returns: maximum of a0 and a1 in a0
max2_s:
    bge a0, a1, max2_s_end  # Branch if a0 >= a1
    mv a0, a1               # Move a1 to a0 if a1 > a0
max2_s_end:
    ret

# Function to find maximum of three signed integers
# Arguments: a0 = first integer, a1 = second integer, a2 = third integer
# Returns: maximum of a0, a1, and a2 in a0
max3_s:
    # Call max2_s to find maximum of first two integers
    jal ra, max2_s

    # Save the result in temporary register t0
    mv t0, a0

    # Call max2_s to find maximum of t0 and third integer (a2)
    mv a0, t0
    mv a1, a2
    jal ra, max2_s

    # The result is in a0
    ret
