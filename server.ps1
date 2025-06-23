$listener = [System.Net.Sockets.TcpListener]::new([Net.IPAddress]::Any, 5000)
$listener.Start()
Write-Host "Listening for HTTP POST requests on port 5000..."

while ($true) {
    $client = $listener.AcceptTcpClient()
    $stream = $client.GetStream()
    $reader = New-Object System.IO.StreamReader($stream, [System.Text.Encoding]::ASCII)
    $writer = New-Object System.IO.StreamWriter($stream, [System.Text.Encoding]::ASCII)
    $writer.NewLine = "`r`n"
    $writer.AutoFlush = $true

    try {
        # Read headers
        $requestLines = @()
        while ($true) {
            $line = $reader.ReadLine()
            if ($null -eq $line -or $line -eq "") { break }
            $requestLines += $line
        }

        # Extract Content-Length
        $contentLength = 0
        foreach ($line in $requestLines) {
            if ($line -match "^Content-Length:\s*(\d+)") {
                $contentLength = [int]$matches[1]
            }
        }

        # Read body
        $body = ""
        if ($contentLength -gt 0) {
            $buffer = New-Object byte[] $contentLength
            $read = 0
            while ($read -lt $contentLength) {
                $read += $stream.Read($buffer, $read, $contentLength - $read)
            }
            $body = [System.Text.Encoding]::UTF8.GetString($buffer)
        }

        Write-Host "`n=== New Request ==="
        Write-Host ($requestLines -join "`n")
        Write-Host "Body: $body"

        # Send response
        $responseBody = "OK"
        $response = "HTTP/1.1 200 OK`r`n" +
                    "Content-Type: text/plain; charset=utf-8`r`n" +
                    "Content-Length: $([System.Text.Encoding]::UTF8.GetByteCount($responseBody))`r`n" +
                    "`r`n" +
                    $responseBody
        $writer.Write($response)
    }
    catch {
        Write-Host "Error processing request: $_"
    }
    finally {
        $writer.Close()
        $reader.Close()
        $client.Close()
    }
}
