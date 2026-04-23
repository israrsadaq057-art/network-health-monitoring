# emergency-failover.ps1
# ONE COMMAND to failover when router dies

param(
    [string]$FailedDevice = "router"
)

Write-Host "========================================" -ForegroundColor Red
Write-Host "  EMERGENCY FAILOVER PROCEDURE" -ForegroundColor Red
Write-Host "========================================" -ForegroundColor Red
Write-Host ""

if ($FailedDevice -eq "router") {
    Write-Host "🔄 Failing over from main router to spare..." -ForegroundColor Yellow
    
    # Step 1: Power down main router
    Write-Host "  1. Power cycling main router..." -ForegroundColor White
    # Uncomment if you have smart PDU
    # Invoke-WebRequest -Uri "http://pdu-ip/cycle?port=1" -Method POST
    
    # Step 2: Bring up spare
    Write-Host "  2. Activating spare router..." -ForegroundColor White
    # Wake-on-LAN magic packet
    $macAddress = "AA:BB:CC:DD:EE:FF"  # Change to spare's MAC
    $wolPacket = [byte[]]@(0xFF,0xFF,0xFF,0xFF,0xFF,0xFF) + ($macAddress -split ':' | ForEach-Object {[Convert]::ToByte($_,16)})
    $udp = New-Object System.Net.Sockets.UdpClient
    $udp.Connect([System.Net.IPAddress]::Broadcast, 9)
    $udp.Send($wolPacket, $wolPacket.Length)
    $udp.Close()
    
    Write-Host "  3. Waiting 30 seconds for spare to boot..." -ForegroundColor White
    Start-Sleep -Seconds 30
    
    # Step 3: Test spare
    Write-Host "  4. Testing spare router..." -ForegroundColor White
    if (Test-Connection "192.168.1.250" -Count 2 -Quiet) {
        Write-Host "✅ Spare router is online!" -ForegroundColor Green
    } else {
        Write-Host "❌ Spare router failed to boot - manual intervention needed" -ForegroundColor Red
    }
    
} elseif ($FailedDevice -eq "ap") {
    Write-Host "🔄 Failing over from failed AP to spare..." -ForegroundColor Yellow
    Write-Host "  1. Unplug failed AP (if not already dead)" -ForegroundColor White
    Write-Host "  2. Plug in spare AP" -ForegroundColor White
    Write-Host "  3. Spare AP should auto-configure" -ForegroundColor White
}

Write-Host ""
Write-Host "⏰ Failover complete. Monitor Grafana for recovery." -ForegroundColor Green