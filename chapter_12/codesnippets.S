//
// Code snippets for Chapter 12
// Examples of
//

.global _start                  // Provide program starting address to linker

_start:

    czero.eqz t0,t1,t2
    czero.nez t0,t1,t2

// Setup the parameters to exit the program
// and then call Linux to do it.
    li      a0,0                // Use 0 return code
    li      a7,93               // Service command code 1 terminates this program
    ecall                       // Call linux to terminate the program

.data
