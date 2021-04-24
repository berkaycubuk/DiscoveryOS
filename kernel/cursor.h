/*
 * kernel/cursor.h
 */

#pragma once
#include "types.h"
#include "io.h"
#define VGA_WIDTH 80

uint_16 cursor_position;

void set_cursor_position(uint_16 position)
{
    out(0x3D4, 0x0F);
    out(0x3D5, (uint_8)(position & 0xFF));
    out(0x3D4, 0x0E);
    out(0x3D5, (uint_8)((position >> 8) & 0xFF));

    cursor_position = position;

    if (cursor_position > 2000) cursor_position = 2000;
    if (cursor_position < 2000) cursor_position = 0;
}

uint_16 position_from_coordinates(uint_8 x, uint_8 y)
{
    return y * VGA_WIDTH + x;
}
