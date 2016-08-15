#!/usr/bin/env python

# from CSAW-CTF 2015 Reverse 200 'Hacking Time' 
# should print "NOHACK4UXWRATHOFKFUHRERX" if success


from z3 import *
import sys

s1 = "703053A1D3703F64B316E4045F3AEE42B1A137156E882AAB".decode('hex')
s2 = "20AC7A25D79CC21D58D01325966ADC7E2EB4B410CB1DC266".decode('hex')

def check(xs, s):
    b = BitVecVal(0, 8)
    for i in xrange(24):
        a = RotateLeft(xs[i], 3)
        b = RotateRight(b, 2)
        a += b
        a ^= ord(s1[i])
        b = a
        a = RotateLeft(a, 4)
        a ^= ord(s2[i])
        s.add(a == 0)
    
    if s.check() == sat:
        m = s.model()
        a = ""
        for i in xrange(24):
            a += chr(int(str((m[xs[i]]))))
            #print m[xs[i]]

            #print hex(int(str(m[xs[i]])))

        print a
    else:
        print "unsat"

def solv():
    s = Solver()
    xs = []
    for i in xrange(24):
        x = BitVec("x%d" % i, 8)
        s.add( 33 <= x )
        s.add( x <= 90 )
        xs.append(x)

    check(xs, s)

solv()
