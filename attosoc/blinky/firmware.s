start:
lui sp, %hi(__stacktop);
addi sp, sp, %lo(__stacktop);

    li s0, 2
    li s1, 0x02000000
    li s3, 256
outerloop:
    addi s0, s0, 1
    blt s0, s3, inrange
    li s0, 2
inrange:
    li s2, 2
innerloop:
    bge s2, s0, prime
    add a0, s0, 0
    add a1, s2, 0
    jal ra, divtest
    beq a0, x0, notprime
    addi s2, s2, 1
    j innerloop
prime:
    sw s0, 0(s1)
    jal ra, delay
notprime:
    j outerloop

divtest: 
    li t0, 1
divloop:
    sub a0, a0, a1
    bge a0, t0, divloop
    jr ra
    
delay:
    li t0, 360000
delayloop0:
    addi t0, t0, -1
    bnez t0, delayloop0

    li t0, 360000
delayloop1:
    addi t0, t0, -1
    bnez t0, delayloop1
    li t0, 360000

delayloop2:
    addi t0, t0, -1
    bnez t0, delayloop2
    jr ra
