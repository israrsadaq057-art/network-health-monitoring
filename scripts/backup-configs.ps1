# backup-configs.ps1
# Run weekly to backup all network device configs

$date = Get-Date -Format "yyyy-MM-dd"
$backupPath = "C:\Monitoring\backups\$date"

# Create backup folder
New-Item -Path $backupPath -ItemType Directory -Force | Out-Null

Write-Host "=== Network Config Backup - $date ===" -ForegroundColor Cyan

# Backup Grafana dashboards
Write-Host "📊 Backing up Grafana dashboards..." -ForegroundColor Yellow
curl -s -u admin:admin "http://localhost:3000/api/search" | ConvertFrom-Json | ForEach-Object {
    $dashboard = curl -s -u admin:admin "http://localhost:3000/api/dashboards/uid/$($_.uid)"
    $dashboard | Out-File "$backupPath\$($_.title).json"
}
Write-Host "✅ Grafana dashboards backed up" -ForegroundColor Green

# Backup Prometheus data (optional - large)
Write-Host "📈 Backing up Prometheus alerts..." -ForegroundColor Yellow
Copy-Item "C:\Monitoring\alertmanager.yml" "$backupPath\alertmanager.yml"
Write-Host "✅ Alert rules backed up" -ForegroundColor Green

# Backup router config (if you have SSH access)
# Write-Host "🖧 Backing up router config..." -ForegroundColor Yellow
# ssh admin@192.168.1.1 "show configuration" > "$backupPath\router-config.txt"

Write-Host ""
Write-Host "✅ Backup complete! Location: $backupPath" -ForegroundColor Green

# Clean old backups (keep last 30 days)
Get-ChildItem "C:\Monitoring\backups" -Directory | Where-Object {
    $_.CreationTime -lt (Get-Date).AddDays(-30)
} | Remove-Item -Recurse -Force
Write-Host "🧹 Cleaned backups older than 30 days" -ForegroundColor Green