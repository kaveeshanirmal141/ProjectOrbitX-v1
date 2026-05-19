# Project OrbitX

![Image Alt](https://github.com/kaveeshanirmal141/Project-OrbitX/blob/main/OrbitX%20Art.jpeg?raw=true)
**Educational Remote Access Trojan (RAT) Lab**  
*For Cybersecurity Students & Red Team / Blue Team Training*

> **⚠️ Educational Use Only** - This tool is built strictly for learning offensive and defensive security in isolated lab environments.

---

## Overview

OrbitX is a simple, custom-built **Python + PowerShell** C2 framework designed to demonstrate:
- Reverse shell communication
- Persistence mechanisms (MITRE T1053.005)
- Process injection & privilege escalation
- Defensive detection techniques

---

## Features

- Reverse TCP Connection with auto-reconnect
- Persistence via Scheduled Task (survives reboot)
- Runs as `NT AUTHORITY\SYSTEM` after reboot
- Screenshot capture
- Open browser (Edge/Chrome)
- Directory navigation (`cd`)
- Restart / Shutdown commands
- Full PowerShell command execution

---

## 
---

## Quick Installation & Setup

### Prerequisites
- Kali Linux (Attacker)
- Windows 10/11 (Victim)
- Both machines on same isolated local network (IMPORTANT)

### 1. On Kali Linux
```bash
git clone https://github.com/yourusername/Project-OrbitX.git
cd Project-OrbitX
python3 c2_server.py

```

### 2. On Windows (Victim Machine)
- Create folder named "Updater" in C:\ProgramData.
- Download agent.ps1 to that folder.
- Convert agent.ps1 to agent.exe

For more detailed installation including converting to .exe is included in SETUP_GUIDE.md

Thank you :)

