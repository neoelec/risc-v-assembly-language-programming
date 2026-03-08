//
// Code snippets for Chapter 6
// Examples of using the stack and calling
// functions.
//

// PUSH/POP macros
.macro PUSH1 register
    addi    sp,sp,-16
    sd      \register,8(sp)
.endm

.macro POP1 register
    ld      \register,8(sp)
    addi    sp,sp,16
.endm

.macro PUSH2 register1, register2
    addi    sp,sp,-16
    sd      \register1,8(sp)
    sd      \register2,0(sp)
.endm

.macro POP2 register1, register2
    ld      \register2,0(sp)
    ld      \register1,8(sp)
    addi    sp,sp,16
.endm

.global _start                  // Provide program starting address to linker

_start:
                                // push t0 to the stack
    addi    sp,sp,-16           // must be a multiple of 16
    sd      t0,8(sp)            // save the value of t0 to the stack

                                // pop t0 from the stack
    ld      t0,8(sp)            // load t0
    addi    sp,sp,16            // restore the stack pointer

                                // push multiple registers to the stack
    addi    sp,sp,-32
    sd      t0,32(sp)
    sd      t1,16(sp)
    sd      t2,8(sp)
    sd      t3,0(sp)

                                // pop multiple registers from the stack
    ld      t3,0(sp)
    ld      t2,8(sp)
    ld      t1,16(sp)
    ld      t0,32(sp)
    addi    sp,sp,32

                                // jal pseudoinstrucitons
    jal     func1               // jal ra, offset
    la      t0,func2
    jalr    t0                  // jalr ra,t0,0

                                // Nested functions
                                // … other code ...
    jal     myfunc
    li      t0,4
                                // … more code …

    li      a0,2
    li      a1,3
    jal     sumfn

                                // demo PUSH/POP macros
    PUSH1   ra
    PUSH2   s0,s1
    POP2    s0,s1
    POP1    ra

// Setup the parameters to exit the program
// and then call Linux to do it.
    li      a0,0                // Use 0 return code
    li      a7,93               // Service command code 1 terminates this program
    ecall                       // Call linux to terminate the program

myfunc:
    addi    sp,sp,-16           // must be a multiple of 16
    sd      ra,8(sp)            // push the return address to the stack

// do some work …
    jal     myfunc2
// do some more work...
    ld      ra,8(sp)            // pop the return address from the stack
    addi    sp,sp,16
    ret

myfunc2:                        // do some work ....
    ret

func1:
    jalr    zero,ra,0           // return using jalr

func2:
    ret                         // ret pseudoinstruction

// Simple function that takes 2 parameters
// VAR1 and VAR2. The function adds them,
// storing the result in a variable SUM.
// The function returns the sum.
// It is assumed this function does other work,
// including calling other functions.

// Define our variables
    .equ    VAR1,0
    .equ    VAR2,8
    .equ    SUM,16

sumfn:
                                // allocate enough on the stack for two registers and
                                // three variables, rounded up to the next multiple of 16.
    addi    sp,sp,-48
    sd      ra,32(sp)           // save the return address
    sd      fp,24(sp)           // save s0/fp
    addi    fp,sp,48            // set fp to the original sp
    sd      a0,VAR1(fp)         // save first param to memory.
    sd      a1,VAR2(fp)         // save second param to memory.

// Do a bunch of other work, but don’t change fp.
// assuming a0 and a1 are used, wiping out originals
// Next restore the variables to registers and perform the addition
    ld      t0,VAR1(fp)
    ld      t1,VAR2(fp)
    add     t2,t0,t1
    sd      t2,SUM(fp)

// Do other work using t2 among other things

// Function Epilog
    ld      a0,SUM(fp)          // load sum to return
    ld      fp,24(sp)           // restore s0/fp
    ld      ra,32(sp)           // restore ra
    addi    sp,sp,48            // release stack storage
    ret
