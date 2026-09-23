#!/bin/bash
gpu=$(timeout 1.5 intel_gpu_top -J -s 1000 2>/dev/null | jq -s '[.[0].engines[]?.busy] // [0] | max | floor' 2>/dev/null)
[ -z "$gpu" ] && gpu=0
cpu=$(vmstat 1 2 | tail -1 | awk '{print 100-$15}')
mem=$(free | awk '/^Mem:/ {printf "%.0f", $3/$2*100}')

python3 -c "
import json
gpu, cpu, mem = '$gpu', '$cpu', '$mem'
icon = \"<span font_family='Font Awesome 7 Free'>\uf1b2</span>\"
text = f'{icon} {gpu}% / C {cpu}% / M {mem}%'
tooltip = f'GPU {gpu}%\nCPU {cpu}%\nMemory {mem}%'
print(json.dumps({'text': text, 'tooltip': tooltip}))
"
