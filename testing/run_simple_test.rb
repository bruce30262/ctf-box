#!/usr/bin/env ruby

# simple check, only check the existence of the tools

require_relative 'myutil'
include Myutil

# pwntools
res = system("python -c 'import pwn'")
if res == true
    puts "pwntools exist"
else
    puts "[!] Can't find pwntools"
end

# ROPGadget
if is_this_installed("ROPgadget")
    puts "ROPgadget exist"
else
    puts "[!] Can't find ROPgadget"
end

# libc-database
if is_dir_exist("#{Dir.home}/libc-database")
    puts "libc-database exist"
else
    puts "[!] Can't find libc-database"
end

# ipython
if is_this_installed("ipython")
    puts "ipython exist"
else
    puts "[!] Can't find ipython"
end

# radare2
if is_this_installed("r2")
    puts "radare2 exist"
else
    puts "[!] Can't find radare2"
end

# Z3
res = system("python -c 'import z3'")
if res == true # start installing
    puts "z3 exist"
else
    puts "[!] Can't find z3"
end

# angr
# first check virtualenv
FIND_VIRTUALENV = "sudo find / -name virtualenvwrapper.sh"
SOURCE_VIRTUALENV = "source $(#{FIND_VIRTUALENV})"
resp = `bash -c '#{SOURCE_VIRTUALENV} && lsvirtualenv'`
if resp.include?"angr"
    puts "angr exist"
else
    puts "[!] Can't find angr"
end

