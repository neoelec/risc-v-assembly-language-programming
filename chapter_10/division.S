//
// Examples of Integer Division
//

#include "debug.inc"

.global main                    // Provide program starting address

// Load the registers with some data
// Perform various division instructions
main:
    li      t0,100
    li      t1,6

    printStr "Inputs:"
    printReg 5
    printReg 6

    div     t2,t0,t1
    rem     t3,t0,t1
    printStr "t0 / t1 (signed):"
    printReg 7
    printStr "t0 %% t1 (signed):"
    printReg 28

    divu    t2,t0,t1
    remu    t3,t0,t1
    printStr "t0 / t1 (unsigned):"
    printReg 7
    printStr "t0 %% t1 (unsigned):"
    printReg 28

                                // Signed division by zero
    li      t1,0
    div     t2,t0,t1
    rem     t3,t0,t1
    printStr "Signed division by zero:"
    printReg 7
    printStr "Signed remainder on division by zero:"
    printReg 28

                                // Unsigned division by zero
    li      t1,0
    divu    t2,t0,t1
    remu    t3,t0,t1
    printStr "Unsigned division by zero:"
    printReg 7
    printStr "Unsigned remainder on division by zero:"
    printReg 28

                                // Overflow
    li      t0,-9223372036854775808
    li      t1,-1
    div     t2,t0,t1
    rem     t3,t0,t1
    printStr "Overflow division:"
    printReg 7
    printStr "Overflow remainder:"
    printReg 28

    li      a0,0                // return code
    ret
