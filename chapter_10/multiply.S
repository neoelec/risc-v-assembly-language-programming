//
// Examples of Multiplication
//

#include "debug.inc"

.global main                    // Provide program starting address

// Load the registers with some data
// Use small positive numbers that will work for all
// multiply instructions.
main:
    li      t0,25
    li      t1,4

    printStr "Inputs:"
    printReg 5
    printReg 6

    mul     t2,t0,t1
    printStr "mul t2=t0*t1:"
    printReg 7

    mulw    t2,t0,t1
    printStr "mulw t2=t0*t1:"
    printReg 7

    ld      t0,A
    ld      t1,B
    printStr "Inputs:"
    printReg 5
    printReg 6
    mulh    t2,t0,t1
    mul     t3,t0,t1
    printStr "mulh t2 = top 64 bits of t0*t1 (signed):"
    printReg 7
    printStr "mul t3 = bottom 64 bits of t0*t1:"
    printReg 28

    mulhu   t2,t0,t1
    mul     t3,t0,t1
    printStr "mulhu t2 = top 64 bits of t0*t1 (unsigned):"
    printReg 7
    printStr "mul t3 = bottom 64 bits of t0*t1:"
    printReg 28

    li      a0,0                // return code
    ret

.data
    .align  16
A:
    .dword  0x7812345678
B:
    .dword  0xfabcd12345678901
