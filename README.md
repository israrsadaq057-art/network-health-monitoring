# Network Health Monitoring System
[![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://docker.com)
[![Grafana](https://img.shields.io/badge/Grafana-F46800?style=for-the-badge&logo=grafana&logoColor=white)](https://grafana.com)
[![Prometheus](https://img.shields.io/badge/Prometheus-E6522C?style=for-the-badge&logo=prometheus&logoColor=white)](https://prometheus.io)
[![License](https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge)](LICENSE)

## Overview

**Predict router and access point failures BEFORE they happen.**

This monitoring system gives you real-time visibility into your network infrastructure and alerts you days before a device fails.

| Feature | Description |
|---------|-------------|
| Live Dashboards | Real-time metrics for all network devices |
| Temperature Monitoring | Detect overheating before failure |
| Memory Trend Analysis | Catch memory leaks early |
| Interface Error Tracking | Find failing cables and ports |
| Uptime Monitoring | Detect unexpected reboots |
| Instant Alerts | Telegram/Slack notifications |

---

A complete monitoring solution for IT infrastructure that predicts router and access point failures BEFORE they happen.

## Features

- Live dashboards for all network devices
- Temperature monitoring to detect overheating
- Memory trend analysis to catch memory leaks
- Interface error tracking for failing cables
- Uptime monitoring for unexpected reboots
- Instant alerts via Telegram or Slack

## Quick Start

Prerequisites:
-Docker Desktop installed

Step 1 - Clone the repository:
git clone https://github.com/israrsadaq057-art/network-health-monitoring.git

Step 2 - Go to the folder:
cd network-health-monitoring

Step 3 - Start the monitoring stack:
docker-compose up -d

Step 4 - Open Grafana:
http://localhost:3000
Username: admin
Password: admin

## What You Can Monitor

Router:
- CPU usage
- Memory usage
- Temperature
- Uptime

Access Points:
- Client count
- Retry rate
- Signal strength

Switches:
- Port errors
- Bandwidth usage
- CRC errors

Servers:
- Disk space
- CPU usage
- RAM usage
- Running services

## Failure Indicators to Watch

Temperature above 70 degrees Celsius for 5 minutes - Replace router within 24 hours
CRC errors above 10 per second - Replace cable immediately
Memory usage above 85 percent - Restart device
Uptime resets unexpectedly - Investigate power or logs
Client count drops by 50 percent - Access point may be failing

## Alert Rules

Critical Temperature:
When router temperature exceeds 70 degrees for 5 minutes
Action: Replace device within 24 hours

High CRC Errors:
When CRC errors exceed 10 per second
Action: Replace cable first, then test port

Memory Leak Detected:
When memory increases without reset
Action: Restart service or device

Unexpected Reboot:
When uptime resets unexpectedly
Action: Check power supply and system logs

## Project Structure

```
network-health-monitoring/
├── docker-compose.yml
├── prometheus.yml
├── alertmanager.yml
├── README.md
├── scripts/
│   ├── setup-monitoring.ps1
│   ├── backup-configs.ps1
│   ├── test-spares.ps1
│   └── emergency-failover.ps1
├── dashboards/
├── docs/
└── configs/

```
## Automation Scripts

setup-monitoring.ps1 - One-click setup of entire system
Run: .\scripts\setup-monitoring.ps1

backup-configs.ps1 - Weekly backup of all configurations
Run: .\scripts\backup-configs.ps1

test-spares.ps1 - Test spare devices
Run: .\scripts\test-spares.ps1

emergency-failover.ps1 - One-click router failover
Run: .\scripts\emergency-failover.ps1

## Success Metrics

Mean Time To Detect: Less than 5 minutes
Mean Time To Recover: Less than 1 hour
False Positive Rate: Less than 5 percent
Devices replaced before failure: 100 percent

## License

MIT License

## Author

Israr Sadaq
GitHub: israrsadaq057-art

## Support

If this project helped you, please give it a star on GitHub.
