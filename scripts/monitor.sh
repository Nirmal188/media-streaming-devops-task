#!/bin/bash
echo "CPU and Memory Usage"
top -b -n 1 | head -n 20
