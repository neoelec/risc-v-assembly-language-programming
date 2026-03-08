// This is a simple Assembly Language program
// to practice using gdb with.

.global _start                  // Provide program starting address to linker

_start:

// load register t0 with 0x12345678
    lui     t0,0x12345
    addi    t0,t0,0x678

    li      t1,10               // load t1 = 10

    add     t2,t0,t1            // add 10 to t0
    sub     t3,t2,t1            // subtract 10 from t2

// Setup the parameters to exit the program
// and then call Linux to do it.

    mv      a0,zero             // Use 0 return code
    li      a7,93               // Service command code 93 terminates
    ecall                       // Call linux to terminate the program
