$BASE = "http://localhost:8080"

# Step 1: Login
$loginBody = @{username="admin_user";password="password123"} | ConvertTo-Json -Compress
Write-Host "Login body: $loginBody"

$loginResp = Invoke-RestMethod -Uri "$BASE/api/auth/signin" -Method POST -ContentType "application/json" -Body $loginBody
$tok = $loginResp.token
Write-Host "Token length: $($tok.Length)"
Write-Host "Token start: $($tok.Substring(0,20))"

# Step 2: Build header explicitly
$authValue = "Bearer $tok"
Write-Host "Auth header: $($authValue.Substring(0,30))"

# Step 3: GET events with explicit header
$getResp = Invoke-RestMethod -Uri "$BASE/api/events" -Method GET -Headers @{Authorization=$authValue}
Write-Host "Events count: $($getResp.Count)"
$getResp | ForEach-Object { Write-Host "  - $($_.title)" }
