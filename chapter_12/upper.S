//
// Assembler program to convert a string to
// all upper case.
//
// a1 - address of output string
// a0 - address of input string
// t4 - original output string for length calc.
// t2 - current character being processed
//

.global toupper                 // Allow other files to call this routine

toupper:
    mv      t4,a1
// The loop is until byte pointed to by x1 is non-zero
loop:
    lb      t2,0(a0)            // load character and increment pointer
    addi    a0,a0,1
// If w5 > 'z' then goto cont
    li      t3,'z'              // is letter > 'z'?
    bgt     t2,t3,cont
// Else if w5 < 'a' then goto end if
    li      t3,'a'
    blt     t2,t3,cont          // goto to end if
// if we got here then the letter is lower case, so convert it.
    addi    t2,t2,('A'-'a')
cont:
                                // end if
    sb      t2,0(a1)            // store character to output str
    addi    a1,a1,1
    li      t3,0
    li      t3,0                // stop on hitting a null character
    bne     t2,t3,loop          // loop if character isn't null
    sub     a0,a1,t4            // get the length by subtracting the pointers
    ret                         // Return to caller
