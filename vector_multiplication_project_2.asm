.data
    vector_a:   .float 2.7, 3.8, 3.5, 4.0, 2.9, 4.7, 3.9, 4.5, 3.4, 3.1, 2.5, 4.1, 
                       2.4, 3.5, 1.7, 1.3, 1.5, 4.6, 2.9, 3.7, 4.5, 4.5, 2.8, 1.2, 
                       1.6, 2.1, 2.6, 2.4, 1.1, 2.1, 2.7, 2.5, 2.4, 2.3, 3.7, 1.8, 
                       1.8, 3.6, 4.1, 2.4, 2.8, 4.1, 1.4, 4.2, 4.8, 1.9, 3.9, 4.2

    vector_b:   .float 4.2, 4.1, 2.8, 4.5, 3.4, 3.7, 4.2, 4.5, 4.5, 3.7, 4.4, 1.2,
                       3.4, 2.6, 2.5, 4.0, 2.5, 1.9, 2.2, 1.9, 2.2, 2.5, 2.3, 4.2, 
                       1.8, 2.9, 4.2, 1.4, 1.4, 3.0, 2.2, 2.6, 1.4, 1.2, 1.6, 3.2, 
                       1.3, 1.5, 4.1, 4.5, 1.5, 3.9, 2.9, 4.1, 4.4, 4.7, 4.6, 1.8
    n:          .word 50
    result:     .float 0.0

.text

main:
    lw $t0, n               # Load the length of vectors into $t0
    li $t1, 0               # Initialize counter i = 0
    l.s $f4, result         # Load initial result value into $f4

loop:
    l.s $f0, vector_a($t1) # Load single precision float from vector_a[i] into $f0 
    l.s $f1, vector_b($t1) # Load single precision float from vector_b[i] into $f1
    
    mul.s $f2, $f0, $f1    # Multiply vector_a[i] * vector_b[i], store in $f2
    add.s $f4, $f4, $f2    # Add $f2 to the running sum in $f4
    
    addi $t1, $t1, 4       # Increment address offset by 4 bytes for next element
    addi $t0, $t0, -1      # Decrement loop count
    
    bne $t0, $zero, loop   # Branch back to loop if count != 0
    
    s.s $f4, result
    
    # Print the result
    li $v0, 2               # syscall code for printing float
    mov.s $f12, $f4         # move the result to print to $f12
    syscall

    # Exit code
    li $v0, 10              # Exit syscall
    syscall
