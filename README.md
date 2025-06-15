
# EstablishedConnectionsGeoLookup

**Author**: Reekash  
**Version**: 1.0  
**License**: MIT  
**Platform**: Windows PowerShell  
**Last Updated**: June 2025

---

## 📌 Overview

**EstablishedConnectionsGeoLookup** is a PowerShell script that retrieves all current **established TCP connections** on a Windows machine and enriches the data by displaying:

- Local and remote IP addresses  
- Connection state  
- Process ID (PID)  
- **Process description** (as shown in Task Manager)  
- **Geolocation** of the remote IP (Region, Country, Organization)

This script helps users **visualize active network traffic**, understand **which remote services/devices are connected**, and provides insights on where those connections are located geographically.

---

## 🔍 Features

- 📡 Uses `netstat` to pull real-time TCP connection data  
- 🌍 Fetches **geolocation info** using [ipinfo.io](https://ipinfo.io) API  
- 🧠 Extracts **process descriptions** for each PID  
- 🛡️ Skips local/private IPs to focus on external communication  
- 📊 Outputs results in a clean table format  
- 🔁 Option to re-run the scan or exit

---

## ✅ Use Cases

- Network diagnostics and traffic inspection  
- Quick reconnaissance of unknown remote connections  
- Security investigations and suspicious connection tracing  
- Educational demonstrations for cybersecurity beginners

---

## 🛠️ Requirements

- PowerShell (Windows built-in)
- Internet connection (for IP geolocation API)
- Execution policy allowing script execution (`Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass`)

---

## 🚀 How to Run

1. Download or clone this repository.
2. Open PowerShell.
3. Navigate to the script location.
4. Run the script:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\EstablishedConnectionsGeo.ps1
```

5. Press `1` to rerun or `2` to exit when prompted.

---

## 📷 Sample Output

```
Protocol  LocalAddress     RemoteAddress     State       PID   ProcessName                  Region     Country   Organisation
--------  -------------    --------------    ---------   ----  --------------------------   -------    -------   ------------
TCP       192.168.1.100:53348  104.17.108.108:443  ESTABLISHED  4321  Google Chrome           California  US        Cloudflare
```

---

## 📬 Contact

Reekash  
Cybersecurity & IT Support Professional  
📍 Melbourne, Australia  

---

## 📄 License

This project is licensed under the MIT License. You are free to use, modify, and distribute it with proper attribution.

---

## 🙌 Acknowledgments

- [ipinfo.io](https://ipinfo.io) for the geolocation API
- PowerShell Community for inspiration

---
