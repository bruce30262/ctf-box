#!/usr/bin/zsh

# from ais3 2016 pre-exam
# should print "ais3{a XOR b XOR 1oo1l}@@@@@@@" if success

source ~/.zshrc

echo "running test case..."
workon angr && python solve-bin3.py &&\
echo "success, deactivating..." &&\
deactivate

