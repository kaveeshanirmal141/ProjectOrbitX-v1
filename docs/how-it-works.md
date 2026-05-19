# How OrbitX Works - Technical Deep Dive

## 1. Initial Execution Flow

1. User runs `agent.exe` (as Administrator)
2. PowerShell script starts and enters an infinite `while($true)` loop
3. Agent attempts a TCP connection to the C2 server (`C2_IP:4444`)
4. On successful connection:
   - Sends greeting message
   - Skips the READY signal from server
   - Waits for commands in a loop

---

# 2. Command Execution Cycle

```text
C2 Server                          Windows Agent
    |                                      |
    |------ "screenshot" ----------------->|
    |                                      |
    |                                      |→ switch -Regex matches command
    |                                      |→ Calls Take-Screenshot() function
    |                                      |→ Saves image in %TEMP%
    |<----- Result + Delimiter ------------|
```

---

# 3. Persistence Deep Dive

When the `persist` command is received:

1. Creates the folder:

```text
C:\ProgramData\Updater
```

2. Registers a Scheduled Task named:

```text
WindowsDriverUpdate
```

3. Configures the task to run `agent.exe` **at startup** as `SYSTEM`

4. On system reboot:
   - Windows automatically launches the task
   - Agent starts with `NT AUTHORITY\SYSTEM` privileges
   - Agent immediately attempts to reconnect to the C2 server

---

# 4. Why Different Privilege Levels?

## Manual Run
Runs under the security context of the user who executed it.

Example:

```text
midhammer\ghost
```

## Scheduled Task Execution
Runs under:

```text
NT AUTHORITY\SYSTEM
```

This occurs because the Scheduled Task is explicitly configured to execute using the `SYSTEM` account.

> `SYSTEM` privileges are higher than even Administrator privileges.

---

# 5. Special Command Handling

| Command | Internal Behavior |
|---|---|
| `cd <path>` | Regex capture + `Set-Location` |
| `screenshot` | Uses `System.Drawing` + `System.Windows.Forms` |
| `restart` | Executes `Restart-Computer` |
| `shutdown` | Executes `Stop-Computer` |
| `google`, `edge`, `browse` | Uses `Start-Process` |

---

# 6. Reconnection Logic

If the connection drops due to:

- C2 server going offline
- Network interruption
- Kali machine reboot

The agent will:

1. Sleep for 8 seconds
2. Retry the connection
3. Continue attempting reconnection indefinitely

This ensures persistence remains functional even if the C2 infrastructure temporarily goes offline.

---

# 7. Known Limitations (Educational)

- Some GUI-based features may behave differently under `SYSTEM` vs normal user context
- No encryption is implemented (kept intentionally simple for learning)
- Scheduled Task is visible in Task Scheduler
- Traffic is not obfuscated
- No stealth or AV evasion mechanisms are implemented

---

# Educational Purpose Disclaimer

Project OrbitX is designed purely for:

- Cybersecurity education
- Malware analysis training
- Red Team lab simulations
- Blue Team detection practice
- Controlled virtual lab environments

It demonstrates real-world attacker concepts in a simplified and transparent manner for ethical learning purposes only.