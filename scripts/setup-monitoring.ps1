# setup-monitoring.ps1
# One-command setup for the entire monitoring system

param(
    [string]$RouterIP = "192.168.1.1"
)

Write-Host @"
╔══════════════════════════════════════════════════════════════════╗
║     Network Health Monitoring System - Setup Script              ║
║                                                                  ║
║  This script will:                                               ║
║  1. Check if Docker is installed and running                     ║
║  2. Create necessary directories                                 ║
║  3. Configure Prometheus with your router IP                     ║
║  4. Start all monitoring containers                              ║
║  5. Install Grafana dashboards                                   ║
╚══════════════════════════════════════════════════════════════════╝
"@ -ForegroundColor Cyan

Write-Host ""

# Step 1: Check Docker
Write-Host "[1/5] Checking Docker..." -ForegroundColor Yellow
$dockerVersion = docker --version 2>$null
if ($dockerVersion) {
    Write-Host "✅ Docker found: $dockerVersion" -ForegroundColor Green
} else {
    Write-Host "❌ Docker not found. Please install Docker Desktop first." -ForegroundColor Red
    exit 1
}

# Step 2: Create directories
Write-Host "[2/5] Creating directories..." -ForegroundColor Yellow
$directories = @("dashboards", "logs", "backups", "configs")
foreach ($dir in $directories) {
    if (!(Test-Path $dir)) {
        New-Item -Path $dir -ItemType Directory -Force | Out-Null
        Write-Host "✅ Created: $dir" -ForegroundColor Green
    }
}

# Step 3: Update prometheus.yml with router IP
Write-Host "[3/5] Configuring Prometheus with router IP: $RouterIP..." -ForegroundColor Yellow
$prometheusFile = "prometheus.yml"
if (Test-Path $prometheusFile) {
    (Get-Content $prometheusFile) -replace '192.168.1.1', $RouterIP | Set-Content $prometheusFile
    Write-Host "✅ Prometheus configured" -ForegroundColor Green
}

# Step 4: Start Docker containers
Write-Host "[4/5] Starting Docker containers (this may take 5-10 minutes first time)..." -ForegroundColor Yellow
docker-compose up -d
Write-Host "✅ Containers started" -ForegroundColor Green

# Step 5: Wait for services
Write-Host "[5/5] Waiting for services to be ready..." -ForegroundColor Yellow
Start-Sleep -Seconds 30

Write-Host ""
Write-Host "╔══════════════════════════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "║                     SETUP COMPLETE!                              ║" -ForegroundColor Green
Write-Host "╠══════════════════════════════════════════════════════════════════╣" -ForegroundColor Green
Write-Host "║                                                                  ║" -ForegroundColor Green
Write-Host "║  📊 Grafana Dashboard:  http://localhost:3000                    ║" -ForegroundColor White
Write-Host "║     Username: admin                                              ║" -ForegroundColor White
Write-Host "║     Password: admin                                              ║" -ForegroundColor White
Write-Host "║                                                                  ║" -ForegroundColor Green
Write-Host "║  📈 Prometheus:        http://localhost:9090                     ║" -ForegroundColor White
Write-Host "║                                                                  ║" -ForegroundColor Green
Write-Host "║  🔔 Alertmanager:      http://localhost:9093                     ║" -ForegroundColor White
Write-Host "║                                                                  ║" -ForegroundColor Green
Write-Host "║  📚 Documentation:     https://github.com/YOUR_USERNAME/         ║" -ForegroundColor White
Write-Host "║                       network-health-monitoring                 ║" -ForegroundColor White
Write-Host "║                                                                  ║" -ForegroundColor Green
Write-Host "╚══════════════════════════════════════════════════════════════════╝" -ForegroundColor Green

Write-Host ""
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "1. Open Grafana and log in" -ForegroundColor White
Write-Host "2. Import dashboard ID: 1860" -ForegroundColor White
Write-Host "3. Configure SNMP on your router (see docs/setup-guide.md)" -ForegroundColor White