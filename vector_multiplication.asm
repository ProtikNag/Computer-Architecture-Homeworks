.data

vector_a:   .word 15, 4, 19, 5, 2, 3, 4, 5
vector_b:   .word 4, 11, 8, 4, 1, 0, 6, 8
n:          .word 8

.text

main:
    # Load the address of vector_a, vector_b, and n into registers
    la $s0, vector_a
    la $s1, vector_b
    lw $t0, n

    # Initialize variables for dot product and loop counter
    li $t1, 0    # Dot product sum
    li $t2, 0    # Loop counter
    li $t3, 0    # Offset value

outer_loop:
    # Load elements a[i] and b[i]
    lw $s2, 0($s0)  # Load a[i] into $s2
    lw $s3, 0($s1)  # Load b[i] into $s3
    li $s4, 0       # multiplication (sum) accumulator
    
multiply_loop:
    # implement multiplication using add
    beq $s3, 0, end_multiply_loop          # stop the loop whenever s3 = 0
    
    add $s4, $s4, $s2       		   # we continue adding s2 to itself
    subi $s3, $s3, 1        		   # continue subtracting 1 from s3
    
    j multiply_loop

end_multiply_loop:
    # update dot product sum 
    add $t1, $t1, $s4

    # Update loop counter and pointers
    addi $t2, $t2, 1    # Increment loop counter
    addi $s0, $s0, 4    # Move to the next element in vector a
    addi $s1, $s1, 4    # Move to the next element in vector b

    # Check if we have processed all elements
    bne $t2, $t0, outer_loop  # If not, repeat the loop

    # The dot product is in $t1
    li $v0, 1
    add $a0, $t1, 0
    syscall

    # Exit the program
    li $v0, 10
    syscall
