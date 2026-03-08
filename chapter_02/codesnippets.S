/* This is a C style comment
 * That can go over multiple lines */
#  This is a more Assembly Language style comment

.global _start                  // Provide program starting address to linker

_start:
                                // All register add variants.
    add     t0,t1,t2
    add     t0,t0,t1
    add     t0,t1,0
    addw    t2,t0,t1

                                // Mv pseudoinstruction
    add     t0,zero,t1
    mv      t0,t1
    addi    t0,t1,0

                                // Immediate instructions
    addi    t2,t1,15
    add     t2,t1,15            // The assembler will change this to addi for you.

    li      t2,15
    lui     t0,0x12345
    addi    t0,t0,0x678

    slli    t2,t0,2

                                // Load 0x1234567890abcdef into register t0
    lui     t0,0x12345          // t0 = 0x12345000
    slli    t0,t0,32            // t0 = 0x1234500000000000
    addi    t1,zero,0x678       // t1 = 0x678
    slli    t1,t1,32            // t1 = 0x67800000000
    add     t0,t0,t1            // t0 = 0x1234567800000000
    addi    t1,zero,0x90a>>1    // t1 = 0x90a>>1
    slli    t1,t1,21            // t1 = 0x90a00000
    add     t0,t0,t1            // t0 = 0x1234567890a00000
    addi    t1,zero,0xbcd>>1    // t1 = 0xbcd>>1
    slli    t1,t1,9             // t1 = 0xbcc00
    add     t0,t0,t1            // t0 = 0x1234567890abcd00
    addi    t0,t0,0x1ef         // t0 = 0x1234567890abcdef

    li      t0,0x1234567890abcdef

    sub     t0,t1,t2

// Setup the parameters to exit the program
// and then call Linux to do it.

    mv      a0,zero             // Use 0 return code
    li      a7,93               // Service command code 93 terminates
    ecall                       // Call linux to terminate the program
