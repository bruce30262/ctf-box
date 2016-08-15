#!/bin/bash

# run this as root to avoid error message while using AFL

echo core >/proc/sys/kernel/core_pattern
