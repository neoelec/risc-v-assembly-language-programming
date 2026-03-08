/*
 * C program to embed our Assembly
 * toupper routine inline.
 */

#include <stdio.h>

int mytoupper(char *str, char *outBuf)
{
    int len;

    __asm__ volatile("mv      t4,%2\n"
                     "loop:\n"
                     "lb      t2,0(%1)\n"
                     "addi    %1,%1,1\n"
                     "li      t3,'z'\n"
                     "bgt     t2,t3,cont\n"
                     "li      t3,'a'\n"
                     "blt     t2,t3,cont\n"
                     "addi    t2,t2,('A'-'a')\n"
                     "cont:\n"
                     "sb      t2,0(%2)\n"
                     "addi    %2,%2,1\n"
                     "li      t3,0\n"
                     "bne     t2,t3,loop\n"
                     "sub     %0,%2,t4\n"
                     : "=r"(len)
                     : "r"(str), "r"(outBuf)
                     : "t2", "t3", "t4", "a0", "a1");

    return len;
}

#define MAX_BUFFSIZE 255

int main(void)
{
    char *str = "This is a test.";
    char outBuf[MAX_BUFFSIZE];
    int len;

    len = mytoupper(str, outBuf);
    printf("Before str: %s\n", str);
    printf("After str: %s\n", outBuf);
    printf("Str len = %d\n", len);

    return 0;
}
