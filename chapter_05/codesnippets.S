// CodeSnippets from Chapter 5.
// Includes examples of all the instructions covered.

.global _start                  // Provide program starting address to linker

.text

_start:

    auipc   t0,0x12345

    la      t0,0x12345678

// All the load instructions
    la      t0,bytes
    lb      t1,0(t0)
    la      t0,halves
    lh      t1,0(t0)
    la      t0,words
    lw      t1,0(t0)
    la      t0,quads
    ld      t1,0(t0)            // RV64I only

    la      t0,bytes
    lbu     t1,0(t0)
    la      t0,halves
    lhu     t1,0(t0)
    la      t0,words
    lwu     t1,0(t0)

// All the load pseudoinstructions
    lb      t0,bytes
    lh      t0,halves
    lw      t0,words
    ld      t0,quads            // RV64I only

    lbu     t0,bytes
    lhu     t0,halves
    lwu     t0,words

// store instructions
    la      t1,bytes
    sb      t0,0(t1)
    srli    t0,t0,8
    sb      t0,1(t1)
    srli    t0,t0,8
    sb      t0,2(t1)

    sh      t0,0(t1)
    sw      t0,0(t1)
    sd      t0,0(t1)

// store pseudoinstructions
    sb      t0,bytes,t1
    sh      t0,bytes,t1
    sw      t0,bytes,t1
    sd      t0,bytes,t1

// load the address of mynumbers into t0
    la      t0,mynumbers
// load the words stored at mynumbers into t3, t4, t5
    lw      t3,0(t0)
    lw      t4,4(t0)
    lw      t5,8(t0)

label:
    auipc   t1,%pcrel_hi(mynumber)
    lw      t1,%pcrel_lo(label)(t1)
                                // t1 now contains 0x12345678.

// load/store with same address in t0.
    la      t0,mynumber         // address of our variable in two instructions
// …
    lw      t1,0(t0)            // load value in one instruction
// …
    sw      t1,0(t0)            // save value in one instruction

#if 0
    li      a0,1                // stdout
    li      a2,26
    li      a7,64               // linux write system call

    lui     a1,%hi(msg)
    addi    a1,a1,%lo(msg)
    ecall                       // Call linux to output the string
#endif

    li      a0,1                // stdout
    li      a2,26
    li      a7,64               // linux write system call

    li      a0,1                // stdout
    li      a2,26
    li      a7,64               // linux write system call

1:
    auipc   a1,%pcrel_hi(msg)
    addi    a1,a1,%pcrel_lo(1b)
    ecall                       // Call linux to output the string

// Initialize x3 as a pointer to the start of the data section.
label1:
    auipc   x3,%pcrel_hi(x3init)
    addi    x3,x3,%pcrel_lo(label1)
// … more code
// Now load the address of msg, perhaps in a loop body
    addi    t0,x3,14            // msg2-x3init
// t0 now contains the address of msg2, obtained in one instruction.
    li      a0,1                // stdout
    mv      a1,t0               // address of string
    li      a2,19               // length of string
    li      a7,64               // linux write system call
    ecall                       // Call linux to output the string

// Setup the parameters to exit the program
// and then call Linux to do it.

    addi    a0,zero,0           // Use 0 return code
    addi    a7,zero,93          // Service command code 93 terminates
    ecall                       // Call linux to terminate the program

.data
    .align  4
bytes:
    .byte   74,0112,0b00101010,0x4a,0X4a,'J','H' + 2
halves:
    .half   0x1234,4949
words:
    .word   0x1234abcd,-1434
quads:
    .quad   0x1234567890abcdef
ascii:
    .ascii  "Hello World\n"
asciz:
    .asciz  "Hello World"
    .balign 4
msg:
    .asciz  "Hi there,how's it going?\n"

negs:
    .byte   -0x45,-33,~0b00111001

zeros:
    .fill   10,4,0

rpn:
    .rept   3
    .byte   0,1,2
    .endr
mynumbers:
    .word   0x12345678,0x9abcdef0,0x1234
mynumber:
    .word   0x12345678

x3init:
msg1:
    .asciz  "First message\n"
msg2:
    .asciz  "This is a message\n"
