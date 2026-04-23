'{"username":"admin_user","password":"password123"}' | Out-File -Encoding ascii -FilePath tmp_l.json
$tok = (& curl.exe -s -X POST "http://localhost:8080/api/auth/signin" -H "Content-Type: application/json" -d "@tmp_l.json" | ConvertFrom-Json).token
Write-Host "Token length: $($tok.Length)"
$result = & curl.exe -s "http://localhost:8080/api/events" -H "Authorization: Bearer $tok"
Write-Host "GET /api/events: $result"
Remove-Item tmp_l.json
