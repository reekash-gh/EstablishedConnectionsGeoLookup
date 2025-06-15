do {
    Clear-Host

    # -------------------------------
    # Display Header
    # -------------------------------
    Write-Host ""
    Write-Host "==============================================================" -ForegroundColor Cyan
    Write-Host "     ESTABLISHED NETWORK CONNECTIONS GEOLOOKUP REPORT" -ForegroundColor Green
    Write-Host "==============================================================" -ForegroundColor Cyan
    Write-Host " Script Author : Reekash" -ForegroundColor Yellow
    Write-Host " Description   : Displays all established TCP connections with" -ForegroundColor Yellow
    Write-Host "                 associated remote geolocation details." -ForegroundColor Yellow
    Write-Host "==============================================================" -ForegroundColor Cyan
    Write-Host ""

    # -------------------------------
    # 1. Retrieve Established TCP Connections
    # -------------------------------
    $connections = netstat -aon | Where-Object { $_ -match "TCP" -and $_ -match "ESTABLISHED" }

    $result = @()

    # -------------------------------
    # 2. Process Each Connection
    # -------------------------------
    foreach ($line in $connections) {
        $columns = ($line -replace '\s{2,}', '|') -split '\|'

        if ($columns.Count -ge 6) {
            $protocol      = $columns[1]
            $localAddress  = $columns[2]
            $remoteAddress = $columns[3]
            $state         = $columns[4]
            $processId     = $columns[5]

            $remoteIP = ($remoteAddress -split ':')[0]

            # -------------------------------
            # 3. Filter Local/Private IPs
            # -------------------------------
            if ($remoteIP -match "^(127\.|10\.|192\.168\.|0\.|::|fe80::)") {
                continue
            }

            # -------------------------------
            # 4. Get Process Description
            # -------------------------------
            try {
                $procInfo = Get-CimInstance Win32_Process -Filter "ProcessId = $processId"
                $processDescription = if ($procInfo.Description) { $procInfo.Description } else { "N/A" }
            }
            catch {
                $processDescription = "N/A"
            }

            # -------------------------------
            # 5. Get GeoIP Info
            # -------------------------------
            try {
                $response = Invoke-RestMethod -Uri "https://ipinfo.io/$remoteIP/json" -ErrorAction Stop
                $org     = $response.org
                $region  = $response.region
                $country = $response.country
            }
            catch {
                $org     = "N/A"
                $region  = "N/A"
                $country = "N/A"
            }

            # -------------------------------
            # 6. Store Result Object
            # -------------------------------
            $result += [PSCustomObject]@{
                Protocol           = $protocol
                LocalAddress       = $localAddress
                RemoteAddress      = $remoteAddress
                State              = $state
                ProcessID          = $processId
                ProcessDescription = $processDescription
                Region             = $region
                Country            = $country
                Organisation       = $org
            }
        }
    }

    # -------------------------------
    # 7. Display Results
    # -------------------------------
    $result | Format-Table -AutoSize

    # -------------------------------
    # 8. Prompt User: Re-run or Exit
    # -------------------------------
    Write-Host ""
    do {
        $choice = Read-Host "Press 1 to re-run the scan, or 2 to exit"
    } while ($choice -notin @('1','2'))

} while ($choice -eq '1')
