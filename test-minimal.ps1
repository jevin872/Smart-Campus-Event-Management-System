'{"username":"admin_user","password":"password123"}' | Out-File -Encoding utf8 -FilePath tmp_login2.json

$tok = (& curl.exe -s -X POST "http://localhost:8080/api/auth/signin" -H "Content-Type: application/json" -d "@tmp_login2.json" | ConvertFrom-Json).token
Write-Host "Token: $tok"

Write-Host "GET events response:"
& curl.exe -v "http://localhost:8080/api/events" -H "Authorization: Bearer $tok" 2>&1

Remove-Item tmp_login2.json
