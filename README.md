# 🎢 Mock POST Server (PowerShell Version)

This is a simple PowerShell-based HTTP mock server for testing POST requests. It receives POST data (typically formatted with `&` delimiters) and prints it to the console. This is ideal for basic testing across localhost or a local network.

---

## ✅ Features

- Accepts HTTP `POST` requests on port `5000`
- Displays the received body and headers
- Returns a valid `HTTP 200 OK` response with `"OK"` in the body

---

## 🖥️ Running the Server (Single Machine - Localhost)

### 1. Save the script

Save the `server.ps1` file anywhere on your system (e.g., Desktop).

### 2. Run the server

Open PowerShell and run the script with:

```powershell
powershell -ExecutionPolicy Bypass -File "C:\Path\To\server.ps1"
```

> Replace the path with the location where you saved the file.

### 3. Send a test request

Open a second PowerShell window and run:

```powershell
Invoke-WebRequest -Uri http://localhost:5000 -Method POST -Body "param1=value1&param2=value2"
```

You should see the string printed in the first PowerShell window.

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
Invoke-WebRequest -Uri http://192.168.1.25:5000 -Method POST -Body "param1=value1&param2=value2"
```

> 🔒 Ensure port 5000 is allowed through the firewall on the server PC.

---

## ⚠️ Notes & Limitations

- This script is **for testing purposes only**.
- The server may need to be **restarted after each request**, as handling multiple or back-to-back requests is not guaranteed.
- To restart, simply close and reopen the PowerShell window and run the script again.