#!/bin/bash

bar="▁▂▃▄▅▆▇█"
dict="s/;//g;"

i=0
while [ $i -lt ${#bar} ]; do
  dict="${dict}s/$i/${bar:$i:1}/g;"
  i=$((i + 1))
done

pipe="/tmp/cava.fifo"
if [ -p $pipe ]; then
  unlink $pipe
fi
mkfifo $pipe

cat <<EOF | cava -p /dev/stdin | sed -u "$dict"
[general]
framerate=60
bars=134
sleep_timer=3

[output]
method=raw
raw_target=/dev/stdout
data_format=ascii
ascii_max_range=7
EOF
