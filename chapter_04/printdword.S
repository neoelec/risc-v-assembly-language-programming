//
// Assembler program to print a register in hex
// to stdout.
//
// a0-a2 (x10-x12) - parameters to linux function services
// a1 - is also address of byte we are writing
// t0 - register to print
// t1 - loop index
// t2 - current character
// a7 (x17) - linux function number
//

.global _start                  // Provide program starting address

_start:
    li      t0,0x1234fedc4f5d6e3a
    la      a1,hexstr           // start of string
    add     a1,a1,17            // start at least sig digit
// The loop is FOR t1 = 16 TO 1 STEP -1
    li      t1,16               // 16 digits to print
loop:
    and     t2,t0,0xf           // mask of least sig digit
// If t2 ≥ 10 then goto letter
    li      t3,10               // is 0-9 or A-F
    bge     t2,t3,letter
// Else its a number so convert to an ASCII digit
    addi    t2,t2,'0'
    j       cont                // goto to end if
letter:                         // handle the digits A to F
    addi    t2,t2,('A'-10)
cont:                           // end if
    sb      t2,0(a1)            // store ascii digit
    addi    a1,a1,-1            // decrement address for next digit
    srli    t0,t0,4             // shift off the digit

                                // next W5
    addi    t1,t1,-1            // step t1 by -1
    bnez    t1,loop             // another for loop if not done

// Setup the parameters to print our hex number
// and then call Linux to do it.
    li      a0,1                // 1 = StdOut
    la      a1,hexstr           // string to print
    li      a2,19               // length of our string
    li      a7,64               // linux write system call
    ecall                       // Call linux to output the string

// Setup the parameters to exit the program
// and then call Linux to do it.
    li      a0,0                // Use 0 return code
    li      a7,93               // Service code 93 terminates
    ecall                       // Call linux to terminate

.data
hexstr:
    .ascii  "0x123456789abcdefG\n"
