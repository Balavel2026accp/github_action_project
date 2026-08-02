#!/bin/bash

REPORT="/tmp/system_monitoring_report.txt"

echo "=========================================" > "$REPORT"
echo "      Ubuntu System Monitoring Report" >> "$REPORT"
echo "=========================================" >> "$REPORT"
echo "" >> "$REPORT"

echo "Hostname: $(hostname)" >> "$REPORT"
echo "IP Address: $(hostname -I)" >> "$REPORT"
echo "Date: $(date)" >> "$REPORT"
echo "" >> "$REPORT"

echo "========== Operating System ==========" >> "$REPORT"
cat /etc/os-release >> "$REPORT"
echo "" >> "$REPORT"

echo "========== Uptime ==========" >> "$REPORT"
uptime >> "$REPORT"
echo "" >> "$REPORT"

echo "========== CPU Usage ==========" >> "$REPORT"
top -bn1 | grep "Cpu(s)" >> "$REPORT"
echo "" >> "$REPORT"

echo "========== Memory Usage ==========" >> "$REPORT"
free -h >> "$REPORT"
echo "" >> "$REPORT"

echo "========== Disk Usage ==========" >> "$REPORT"
df -h >> "$REPORT"
echo "" >> "$REPORT"

echo "========== Load Average ==========" >> "$REPORT"
cat /proc/loadavg >> "$REPORT"
echo "" >> "$REPORT"

echo "========== Top 10 CPU Processes ==========" >> "$REPORT"
ps -eo pid,user,%cpu,%mem,comm --sort=-%cpu | head -11 >> "$REPORT"
echo "" >> "$REPORT"

echo "========== Top 10 Memory Processes ==========" >> "$REPORT"
ps -eo pid,user,%cpu,%mem,comm --sort=-%mem | head -11 >> "$REPORT"
echo "" >> "$REPORT"

echo "========== Network Interfaces ==========" >> "$REPORT"
ip addr show >> "$REPORT"
echo "" >> "$REPORT"

echo "========== Listening Ports ==========" >> "$REPORT"
ss -tulnp >> "$REPORT"
echo "" >> "$REPORT"

echo "========== Logged In Users ==========" >> "$REPORT"
who >> "$REPORT"
echo "" >> "$REPORT"

echo "========== Failed Login Attempts ==========" >> "$REPORT"
sudo lastb 2>/dev/null | head >> "$REPORT"
echo "" >> "$REPORT"

echo "========== Running Services ==========" >> "$REPORT"
systemctl --type=service --state=running | head -30 >> "$REPORT"
echo "" >> "$REPORT"

echo "Report generated successfully."
echo "Location: $REPORT"