.global max2_s
.global max3_s

max2_s:
    # Compare a0 and a1
    bge a0, a1, max3_s
    mv a0, a1   # If a1 is bigger, store it in a0

max3_s:
    # Compare a0 (which could be a0 or a1 now) and a2
    bge a0, a2, end_max3_s
    mv a0, a2   # If a2 is bigger, store it in a0

end_max3_s:
    # The biggest number is in a0, so return it
    mv a0, a0
    ret
