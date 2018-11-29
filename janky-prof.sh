#!/bin/bash
if [ `cat /proc/sys/kernel/yama/ptrace_scope` -eq "1" ] ; then echo 0 |sudo tee /proc/sys/kernel/yama/ptrace_scope; fi

pidof $1||exit
while pidof $1 |xargs -n1 gdb --batch -ex "thread apply all bt" -p; do sleep 2; done | sed 's/^\(\#.*\ at\ \)\(.*\)/\2:\1/g'
