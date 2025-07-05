# 🎢 Mock POST Server (PowerShell Version)

This is a simple PowerShell-based HTTP mock server for testing JSON POST requests. It receives JSON payloads, validates the JSON format, logs the payload to the console, and responds indicating whether the JSON is valid or invalid. Ideal for basic API testing across localhost or a local network.

---

## ✅ Features

- Accepts HTTP `POST` requests on port `5000`
- Reads and logs JSON payloads sent in the request body
- Validates JSON format and responds with "Valid JSON" or an error message
- Returns HTTP `200 OK` response with plain text feedback

---

## 🖥️ Running the Server (Single Machine - Localhost)

### 1. Save the script

Save the `server.ps1` file anywhere on your system (e.g., Desktop).

### 2. Run the server

Open PowerShell and run the script with:

```powershell
powershell -ExecutionPolicy Bypass -File "C:\\Path\\To\\server.ps1"
```

> Replace the path with the location where you saved the file.

### 3. Send a test request

Open a second PowerShell window and run:

```powershell
Invoke-RestMethod -Uri http://localhost:5000 -Method POST -Body (Get-Content -Raw -Path .\\test.json) -ContentType "application/json"
```

Replace `test.json` with your JSON file containing the payload to test.

---

## 🌐 Running Between Two Machines (LAN/Wi-Fi)

### On the server PC:

1. Run the PowerShell server script:

```powershell
powershell -ExecutionPolicy Bypass -File "C:\Path\To\server.ps1"
```

2. Find your local IP address:

```powershell 
ipconfig
```

Look for the `IPv4 Address` (e.g., `192.168.1.25`).

### On the client PC:

Use the IP address of the server PC in the POST request:

```powershell
Invoke-RestMethod -Uri http://192.168.1.25:5000 -Method POST -Body (Get-Content -Raw -Path .\\test.json) -ContentType "application/json"
```

> 🔒 Ensure port 5000 is allowed through the firewall on the server PC.

---

## ⚠️ Notes & Limitations

- This script is **for testing JSON POST requests only**.
- It validates JSON format but does **not perform deep schema validation**.
- The server handles requests serially and runs continuously until manually stopped.
- Use `Ctrl+C` in the PowerShell window running the server to stop it.

---