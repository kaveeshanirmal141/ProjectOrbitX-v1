# Cleanup Guide for Project OrbitX

This guide explains how to completely remove OrbitX from the Windows lab machine after testing or demonstrations.

---

# Quick Cleanup (Recommended)

Run the following commands in an **Administrator PowerShell** window on the Windows machine:

```powershell
# 1. Remove the Scheduled Task (Persistence)
Unregister-ScheduledTask -TaskName "WindowsDriverUpdate" -Confirm:$false -ErrorAction SilentlyContinue

# 2. Kill any running OrbitX agent
Get-Process -Name "agent" -ErrorAction SilentlyContinue | Stop-Process -Force

# 3. Remove Defender Exclusions
Remove-MpPreference -ExclusionPath "C:\ProgramData\Updater" -ErrorAction SilentlyContinue
Remove-MpPreference -ExclusionProcess "agent.exe" -ErrorAction SilentlyContinue

# 4. Delete OrbitX files and folder
Remove-Item -Path "C:\ProgramData\Updater" -Recurse -Force -ErrorAction SilentlyContinue

Write-Host "OrbitX has been successfully cleaned up!" -ForegroundColor Green
```

---

# Manual Step-by-Step Cleanup

## 1. Remove Scheduled Task

```powershell
Unregister-ScheduledTask -TaskName "WindowsDriverUpdate" -Confirm:$false
```

---

## 2. Stop Running Agent

```powershell
Get-Process -Name "agent" | Stop-Process -Force
```

---

## 3. Remove Microsoft Defender Exclusions

```powershell
Remove-MpPreference -ExclusionPath "C:\ProgramData\Updater"

Remove-MpPreference -ExclusionProcess "agent.exe"
```

---

## 4. Delete OrbitX Files and Folder

```powershell
Remove-Item -Path "C:\ProgramData\Updater" -Recurse -Force
```

---

# Alternative One-Liner (Full Cleanup)

```powershell
Unregister-ScheduledTask -TaskName "WindowsDriverUpdate" -Confirm:$false -ErrorAction SilentlyContinue; Get-Process -Name "agent" -ErrorAction SilentlyContinue | Stop-Process -Force; Remove-MpPreference -ExclusionPath "C:\ProgramData\Updater" -ErrorAction SilentlyContinue; Remove-MpPreference -ExclusionProcess "agent.exe" -ErrorAction SilentlyContinue; Remove-Item -Path "C:\ProgramData\Updater" -Recurse -Force -ErrorAction SilentlyContinue; Write-Host "OrbitX Cleanup Completed!" -ForegroundColor Green
```

---

# Verification Commands

After cleanup, run the following commands to verify that OrbitX has been fully removed.

## Check if Scheduled Task Exists

```powershell
Get-ScheduledTask | Where-Object TaskName -eq "WindowsDriverUpdate"
```

---

## Check if OrbitX Folder Exists

```powershell
Test-Path "C:\ProgramData\Updater"
```

---

## Check if Agent Process Is Running

```powershell
Get-Process -Name "agent" -ErrorAction SilentlyContinue
```

Expected result:

- No running process
- No scheduled task
- Folder path returns `False`

---

# Important Notes

- Always run cleanup commands in **Administrator PowerShell**
- If you receive `Access Denied`, terminate `agent.exe` first
- Restarting the machine after cleanup is recommended
- Defender exclusions may require elevated permissions to remove

---

# Final Result

After completing these steps, all known OrbitX persistence mechanisms, files, processes, and Defender exclusions should be removed from the system.

This cleanup process is intended for educational lab environments only.