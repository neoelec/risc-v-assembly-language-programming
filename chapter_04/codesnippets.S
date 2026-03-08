// CodeSnippets from Chapter 4.
// Includes examples of all the instructions covered.

.global _start                  // Provide program starting address to linker

_start:

                                // Unconditional jump instructions
    jal     t0,label            // direct jump
    la      t1,label
    jalr    t0,t1,32            // indirect jump

    j       label

label:
    li      t0,1
    j       _start

    beq     t0,t1,label         // branch if equal
    bne     t0,t1,label         // branch if not equal
    blt     t0,t1,label         // branch if rs1 < rs2 (signed)
    bge     t0,t1,label         // branch if rs1 ≥ rs2 (signed)
    bltu    t0,t1,label         // branch if rs1 < rs2 (unsigned)
    bgeu    t0,t1,label         // branch if rs1 ≥ rs2 (unsigned)

    beqz    t0,label            // beq t0,zero,label // Branch if = zero
    bnez    t0,label            // bne t0,zero,label // Branch if ≠ zero
    blez    t0,label            // bge zero,t0,label // Branch if ≤ zero
    bgez    t0,label            // bge t0,zero,label // Branch if ≥ zero
    bltz    t0,label            // blt t0,zero,label // Branch if < zero
    bgtz    t0,label            // blt zero,t0,label // Branch if > zero
    bgt     t0,t1,label         // blt t1,t0,label   // Branch if >
    ble     t0,t1,label         // bge t1,t0,label   // Branch if ≤
    bgtu    t0,t1,label         // bltu t1,t0,label  // Branch if >, unsigned
    bleu    t0,t1,label         // bltu t1,t0,label  // Branch if ≤, unsigned

// FOR/NEXT loop
    li      t0,1                // t0 holds I
loop:                           // The body of the loop goes here.
                                // Most of the logic is at the end
    addi    t0,t0,1             // I = I + 1
    li      t1,10               // end of loop for comparison
    ble     t0,t1,loop          // IF I < 10 goto loop

// WHILE Loop
// t0 is X and has been initialized
loop2:
    li      t1,5
    bge     t0,t1,loopdone
                                // … other statements in the loop body …
    j       loop2
loopdone:                       // program continues

// IF/THEN/ELSE Statement
    li      t1,10
    bge     t0,t1,elseclause

                                // … if statements …

    j       endif
elseclause:

                                // … else statements …

endif:                          // continue on after the /then/else …

// Bitwise logic instructions
    and     t1,t0,t2
    andi    t1,t0,0xff
    or      t1,t0,t2
    ori     t1,t0,0xff
    xor     t1,t0,t2
    xori    t1,t0,0xff

// mask off the high order byte
    li      t1,0xff000000       // mask value to t1
    and     t0,t0,t1
// right shift the byte down to the low order position.
    srli    t0,t0,24

    ori     t1,t1,0xff

// Conditional set instructions
    slt     t2,t0,t1            // t2 = 1 if t0 < t1, else t2 = 0
    slti    t2,t0,10            // t2 = 1 if t0 < 10 else t2 = 0
    sltu    t2,t0,t1            // like slt, but for unsigned integers
    sltiu   t2,t0,10            // like slti, but for unsigned integers

// Pseudoinstructions for conditional set instructions
    seqz    t2,t0               // set t2 = 1 if t0 = 0
    snez    t2,t0               // set t2 = 1 if t0 ≠ 0
    sltz    t2,t0               // set t2 = 1 if t0 < 0
    sgtz    t2,t0               // set t2 = 1 if t0 > 0

// Setup the parameters to exit the program
// and then call Linux to do it.

    addi    a0,zero,0           // Use 0 return code
    addi    a7,zero,93          // Service command code 93 terminates
    ecall                       // Call linux to terminate the program
