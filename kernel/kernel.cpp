/*
 * kernel/kernel.cpp
 *
 * 2021 Berkay Çubuk 
 */

#include "cursor.h"
#include "print.h"

extern "C" void kernel()
{
    print("Hello DiscoveryOS");
}
