#!/bin/bash

echo "=== SERVER PERFORMANCE STATS ==="
echo

# OS Info
echo "OS Version:"
uname -a
echo

# Uptime
echo "Uptime:"
uptime
echo

# CPU Usage
echo "Total CPU Usage:"
top -bn1 | grep "Cpu(s)" | \
awk '{print "User: " $2 "%, System: " $4 "%, Idle: " $8 "%"}' \
awk '{printf "  Used: %.2f%%\n", 100 - $8}'
echo

# Memory Usage
echo "Memory Usage:"
free -h | awk '/^Mem/ { 
    printf("Used: %.2f GB, Free: %.2f GB, Usage: %.2f%%\n", 
    ($3/1024), ($4/1024), ($3/$2)*100) 
}'
echo
# Memory Usage(alternatively)
echo "🧠 Memory Usage:"
free -h | awk 'NR==2{printf "  Used: %s / %s (%.2f%%)\n", $3, $2, $3*100/$2}'
echo

# Disk Usage
echo "Disk Usage:"
df -h --total | awk '/^total/ { 
    printf("Used: %s, Free: %s, Usage: %s\n", $3, $4, $5) 
}'
echo

# Disk Usage(alternatively)
echo "💽 Disk Usage:"
df -h --total | awk 'END{printf "  Used: %s / %s (%s)\n", $3, $2, $5}'
echo

# Top 5 processes by CPU
echo "Top 5 Processes by CPU Usage:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
echo

# Top 5 processes by Memory usage(alternatively)
echo "💾 Top 5 Processes by Memory Usage:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6 | column -t
echo

# Top 5 processes by Memory
echo "Top 5 Processes by Memory Usage:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6
echo

# Logged-in users
echo "Logged In Users:"
who
echo

# Optional stretch stats
echo "🛠️ Additional Info:"
echo "  OS Version: $(lsb_release -ds 2>/dev/null || cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2)"
echo "  Uptime: $(uptime -p)"
echo "  Load Average: $(uptime | awk -F'load average:' '{ print $2 }')"
echo "  Logged In Users: $(who | wc -l)"
echo

# Failed login attempts (if available)
if [ -f /var/log/auth.log ]; then
    echo "Failed Login Attempts:"
    grep "Failed password" /var/log/auth.log | wc -l
else
    echo "Auth log not available to check failed login attempts."
fi

# Failed login attempts (optional: depends on log file availability and format)
if [ -f /var/log/auth.log ]; then
    echo "🚫 Failed Login Attempts:"
    grep "Failed password" /var/log/auth.log | wc -l
elif [ -f /var/log/secure ]; then
    echo "🚫 Failed Login Attempts:"
    grep "Failed password" /var/log/secure | wc -l
else
    echo "🚫 Failed Login Attempts: Log file not found."
fi

echo
echo "=== End of Report ==="

