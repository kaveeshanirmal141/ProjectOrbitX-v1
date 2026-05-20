# Future Upgrades & Roadmap for Project OrbitX

This document outlines planned and potential improvements for **Project OrbitX**.

---

## Phase 1 - Next Releases (v1.1 - v1.3)

### v1.1 - File Operations (High Priority)
- File Upload (Victim → C2)
- File Download (C2 → Victim)
- Directory listing with size and date
- File search functionality

### v1.2 - Stealth & Evasion
- Process hollowing / injection techniques
- AMSI bypass methods
- String obfuscation in agent
- Anti-analysis / sandbox detection
- Run as different user (token impersonation)

### v1.3 - Advanced Features
- Basic Keylogger
- Clipboard monitoring
- Webcam capture (if possible)
- Microphone recording stub
- Password dumping (browser + Windows credentials)

---

## Phase 2 - Medium Term

- **Encrypted Communication** (AES or XOR)
- **Multiple Sessions** support in C2
- **Beaconing** with jitter (random delay)
- **Domain Generation Algorithm (DGA)** simulation
- **In-memory execution** (fully fileless)
- **C2 over HTTP/HTTPS** (more stealthy)
- **Linux Agent** (cross-platform)

---

## Phase 3 - Long Term (Advanced)

- GUI Dashboard for C2 (Tkinter or Web-based)
- Plugin system for agents
- Automated Blue Team detection rules (Sigma / YARA)
- MITRE ATT&CK mapping for every technique
- Virtual Machine / Sandbox evasion
- Persistence alternatives (Registry Run keys, WMI, Startup Folder, etc.)

---

## Nice-to-Have Features

- Auto screenshot on connection
- Live screen streaming (low quality)
- Remote CMD / PowerShell prompt
- Process injection & migration
- Self-deletion after cleanup
- Config file for easy customization (IP, Port, etc.)

---

## Development Priorities

| Priority | Feature                    | Difficulty | Educational Value |
|----------|---------------------------|------------|-------------------|
| High     | File Upload/Download       | Medium     | Very High         |
| High     | Keylogger                  | Medium     | Very High         |
| Medium   | Communication Encryption   | High       | High              |
| Medium   | HTTP/S C2                  | High       | Very High         |
| Low      | GUI Dashboard              | High       | Medium            |

---

## Contribution Guidelines

Feel free to:
- Open Issues for bugs or new ideas
- Submit Pull Requests for new features
- Suggest new techniques

**Goal**: Make OrbitX the best **educational** open-source RAT for cybersecurity students.

---

**Last Updated**: May 2026  
**Current Version**: 1.0

---

You can now create the file `docs/future_upgrades.md` and paste the content above.

---

Would you like me to create the **full `SETUP_GUIDE.md`** (the most important one for users) next?