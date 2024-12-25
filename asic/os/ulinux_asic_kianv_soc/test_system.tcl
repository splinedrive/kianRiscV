#!/usr/bin/expect -f

set timeout 10

# Run the simulation
spawn make sim

# Wait for shell prompt
expect "/ #"
send "uname -om\r"
expect "riscv32 GNU/Linux"

expect "/ #"
send "cat /etc/os-release\r"
expect "NAME=Buildroot"

expect "/ #"
send "halt\r"
expect "reboot: System halted"
