val="0.0"
count=0

for cpu_dir in /sys/devices/system/cpu/cpu[0-9]* 
do
     freq_folder="${cpu_dir}/cpufreq"

     curr_freq=$(cat "${freq_folder}/scaling_cur_freq")
     max_freq=$(cat "${freq_folder}/scaling_max_freq")

     usage=$(awk "BEGIN {printf ${curr_freq} / ${max_freq}}")

     val=$(awk "BEGIN {printf ${usage} + ${val}}")
     ((count++))
done

ft=$(awk "BEGIN {printf 100 * ${val} / ${count}}")

printf "%.0f%%" $ft

