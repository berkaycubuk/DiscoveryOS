extern "C" void kernel()
{
    const short color = 0x0F00;
    const char* hello = "Hello cpp!";
    short* vga = (short*)0xb8000;
    for (int i = 0; i < 16; i++ )
        vga[i+18] = color | hello[i];
}
