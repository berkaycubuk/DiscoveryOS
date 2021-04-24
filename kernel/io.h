/*
 * kernel/io.h
 */

#pragma once
#include "types.h"

void out(uint_16 port, uint_8 value)
{
    asm volatile ("outb %0, %1" : : "a"(value), "Nd"(port));
}

uint_8 in(uint_16 port)
{
    uint_8 value;
    asm volatile ("inb %1, %0" : "=a"(value) : "Nd"(port));
    return value;
}
