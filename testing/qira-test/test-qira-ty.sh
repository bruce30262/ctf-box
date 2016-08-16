#!/bin/bash

# test qira on ty (aarch64 binary)
# service: localhost:4000
# qira: localhost:3002

QEMU_LD_PREFIX=/usr/aarch64-linux-gnu qira -s ../ARM-test/ty/real_ty
