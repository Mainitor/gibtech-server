$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://+:5000/")
try {
    $listener.Start()
    Write-Host "Listening on http://localhost:5000 ..."

    while ($listener.IsListening) {
        try {
            $context = $listener.GetContext()
        } catch {
            Write-Host "Listener stopped or failed: $_"
            break
        }

        $request = $context.Request
        $response = $context.Response

        try {
            $reader = New-Object System.IO.StreamReader($request.InputStream)
            $body = $reader.ReadToEnd()
            $reader.Close()

            Write-Host "`n=== New Request ==="
            Write-Host "$($request.HttpMethod) $($request.Url.AbsolutePath)"
            Write-Host "Body: $body"

            # JSON validation
            try {
                $json = $body | ConvertFrom-Json
                $responseBody = "Valid JSON"
            } catch {
                $responseBody = "Invalid JSON: $_"
            }

            $buffer = [System.Text.Encoding]::UTF8.GetBytes($responseBody)
            $response.ContentLength64 = $buffer.Length
            $response.ContentType = "text/plain"
            $response.OutputStream.Write($buffer, 0, $buffer.Length)
        }
        catch {
            Write-Host "Error handling request: $_"
        }
        finally {
            if ($response -ne $null) { $response.Close() }
        }
    }
}
catch {
    Write-Host "Fatal error starting listener: $_"
}
finally {
    if ($listener -ne $null -and $listener.IsListening) {
        $listener.Stop()
        $listener.Close()
    }
}
