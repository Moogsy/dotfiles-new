cat /proc/meminfo | head -n 2 | awk '{print $2}'
