# Architecture of Project OrbitX

## Overview

**Project OrbitX** is a lightweight educational Command & Control (C2) framework designed to demonstrate real-world RAT (Remote Access Trojan) techniques in an isolated lab environment.

It consists of two primary components:

- **C2 Server** (`c2_server.py`) — Attacker side (Kali Linux)
- **Agent** (`agent.ps1` → `agent.exe`) — Victim side (Windows)

---

## High-Level Architecture Diagram

```mermaid
graph TD
    A[OrbitX C2 Server<br/>(Kali Linux - Port 4444)] <-->|Reverse TCP Connection| B[OrbitX Agent<br/>(Windows 11)]
    B --> C[Scheduled Task Persistence<br/>(WindowsDriverUpdate)]
    B --> D[PowerShell Execution Engine]
    B --> E[Screenshot Capture & GUI Interaction]
    B --> F[File System Access]
```
### Component Details

**C2 Server (c2_server.py)**

- Language: Python 3
- Function: Multi-threaded TCP server listening on port 4444
- Key Features:
- Custom protocol with response delimiter (===END_OF_RESPONSE===)
- Automatic session handling
- Clean OrbitX> interactive prompt
- Fancy ASCII banner on startup

**Windows Agent (agent.ps1/agent.exe)**

- Language: PowerShell (compiled to EXE)
- Core Mechanism: Infinite while($true) loop with reconnection logic
- Reconnection Delay: 8 seconds

**Persistence Mechanism (MITRE ATT&CK T1053.005)**

```bash
Register-ScheduledTask `
    -TaskName "WindowsDriverUpdate" `
    -User "SYSTEM" `
    -Action (New-ScheduledTaskAction -Execute "C:\ProgramData\Updater\agent.exe") `
    -Trigger (New-ScheduledTaskTrigger -AtStartup)

```
**Why it works ?**

- Runs automatically at system startup
- Executes with NT AUTHORITY\SYSTEM privileges (highest level)
- Survives reboots and user logoffs

**Network Communication**

- Type: Reverse Shell (Agent connects outbound to C2)
- Port: 4444 (TCP)
- Advantage: Bypasses most firewall restrictions on inbound connections

**Privilege Escalation Flow**

- Manual Execution: Runs under current logged-in user (midhammer\ghost)
- After Persistence + Reboot: Runs as NT AUTHORITY\SYSTEM

- This escalation occurs because the Scheduled Task is explicitly configured to run under the SYSTEM account.
