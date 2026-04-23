# test-spares.ps1
# Run weekly to test spare devices

$spareRouterIP = "192.168.1.250"  # Change to your spare's IP
$spareAPIP = "192.168.1.251"       # Change to your spare AP's IP

Write-Host "=== Testing Network Spare Devices ===" -ForegroundColor Cyan

# Test spare router
Write-Host "🖧 Testing spare router..." -ForegroundColor Yellow
if (Test-Connection $spareRouterIP -Count 1 -Quiet) {
    Write-Host "✅ Spare router is online and responding" -ForegroundColor Green
} else {
    Write-Host "❌ Spare router is OFFLINE - Needs attention!" -ForegroundColor Red
    # Send alert
}

# Test spare AP
Write-Host "📡 Testing spare access point..." -ForegroundColor Yellow
if (Test-Connection $spareAPIP -Count 1 -Quiet) {
    Write-Host "✅ Spare AP is online and responding" -ForegroundColor Green
} else {
    Write-Host "❌ Spare AP is OFFLINE - Needs attention!" -ForegroundColor Red
}

# Test spare power supplies
Write-Host "🔌 Testing spare power supplies..." -ForegroundColor Yellow
Write-Host "✅ Please visually inspect spare power supplies" -ForegroundColor Yellow

Write-Host ""
Write-Host "Spare Device Inventory:" -ForegroundColor Cyan
Write-Host "  Router: 1 unit (IP: $spareRouterIP)" -ForegroundColor White
Write-Host "  AP: 1 unit (IP: $spareAPIP)" -ForegroundColor White
Write-Host "  Power supplies: 2 units" -ForegroundColor White