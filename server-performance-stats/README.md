# Server Performance Stats Script

This Bash script collects and displays key server performance statistics in a clear, easy-to-read format. It helps monitor CPU, memory, disk usage, top resource-consuming processes, uptime, logged-in users, and failed login attempts.

---

## Features

- CPU usage percentage
- Memory usage with human-readable values
- Disk usage summary with total used and available space
- Top 5 CPU-consuming processes
- Top 5 memory-consuming processes
- Operating system version
- System uptime and load averages
- Number of logged-in users
- Count of failed login attempts (from auth logs)

---

## How to Use

1. Save the script to a file, for example `server_stats.sh`.
2. Make it executable:
   ```bash
   chmod +x server_stats.sh

