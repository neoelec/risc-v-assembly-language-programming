//
// Assembler program to convert a string to
// all upper case.
//
// a0-a2 - parameters to Linux function services
// t0 - address of output string
// t1 - address of input string
// t2 - current character being processed
// a7 - linux function number
//

.global _start                  // Provide program starting address to linker

_start:
.option push
.option norelax
1:
    auipc   gp,%pcrel_hi(__global_pointer$)
    addi    gp,gp,%pcrel_lo(1b)
.option pop

    la      t0,outstr           // address of output string
    la      t1,instr            // start of input string

// The loop is until null (zero) character is encountered.
loop:
    lb      t2,0(t1)            // load character
    addi    t1,t1,1             // increment buffer pointer
// If t2 > 'z' then goto cont
    li      t3,'z'              // load 'z' for comparison
    bgt     t2,t3,cont          // branch if letter > 'z'?
// Else if t2 < 'a' then goto end if
    li      t3,'a'              // load 'a' for comparison
    blt     t2,t3,cont          // goto to end if not lowercase
// if we got here then the letter is lower case, so convert it.
    addi    t2,t2,('A'-'a')
cont:                           // end if
    sb      t2,0(t0)            // store character to output str
    addi    t0,t0,1             // increment buffer for next char
    li      t3,0                // load 0 char for comparison
    bne     t2,t3,loop          // loop if character isn't null

// Setup the parameters to print our hex number
// and then call Linux to do it.
    li      a0,1                // 1 = StdOut
    la      a1,outstr           // string to print
    sub     a2,t0,a1            // get the len by sub’ing the pointers
    li      a7,64               // Linux write system call
    ecall                       // Call Linux to output the string

// Setup the parameters to exit the program
// and then call Linux to do it.
    li      a0,0                // Use 0 return code
    li      a7,93               // Service code 93 terminates
    ecall                       // Call Linux to terminate the program

.data
gpinit:
    .quad   . + 0x800
instr:
    .asciz  "This is our Test String that we will convert.\n"
outstr:
    .fill   255,1,0
