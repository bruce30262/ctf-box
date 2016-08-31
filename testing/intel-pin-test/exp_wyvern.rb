#!/usr/bin/env ruby

# test intel-pin's inscount0
# testing binary from CSAWCTF 2015 rev500 'wyvern'

puts "checking pintool..."
resp = `cat /proc/sys/kernel/yama/ptrace_scope`.strip().to_i
if resp == 1
    puts "Modifying ptrace scope..."
    system("echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope")
    puts "pintool is ready to run !"
else
    puts "pintool is ready to run !"
end

all_str = []
for i in (48..57)
    all_str << i.chr
end
for i in (97..122)
    all_str << i.chr
end
for i in (65..90)
    all_str << i.chr
end
all_str << "_"
all_str << "@"
cur_max = 0
index = 0
key = "dr4g0n_or_p4tric1an_it5_LLV"

while true
    now = key + all_str[index]
    input = now.ljust(28, "1")
    puts "Trying: #{input}"
    cmd = "echo \"#{input}\" | #{Dir.home}/pin/pin -t #{Dir.home}/pin/source/tools/ManualExamples/obj-intel64/inscount0.so -- ./wyvern; cat inscount.out"
    #puts cmd
    resp = `#{cmd}`
    cnt = resp.split("\n")[9].split(" ")[1].to_i
    puts cnt
    if cnt == 0
        puts "end"
        break
    end
    if cur_max == 0 or index == 0
        cur_max = cnt
        index += 1
    else
        if cnt > cur_max
            key = now
            puts "Key: #{key}"
            cur_max = cnt
            index = 0
        elsif cnt < cur_max
            key += all_str[index-1]
            puts "Key: #{key}"
            cur_max = cnt
            index = 0
        elsif cnt == cur_max
            index += 1
        end
    end
end
