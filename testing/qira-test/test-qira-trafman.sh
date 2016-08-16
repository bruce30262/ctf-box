#!/bin/bash

# test qira on trafman (armhf binary)
# service: localhost:4000
# qira: localhost:3002

QEMU_LD_PREFIX=/usr/arm-linux-gnueabihf qira -s ../ARM-test/trafman/real_trafman
