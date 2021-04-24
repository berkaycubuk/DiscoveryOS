/*
 * kernel/print.h
 */

#include "types.h"

void print(const char* str)
{
    static unsigned short* VideoMemory = (unsigned short*)0xb8000;

    for (int i=0; str[i]!='\0'; i++)
        VideoMemory[i] = (VideoMemory[i] & 0xFF00)|str[i];
}
