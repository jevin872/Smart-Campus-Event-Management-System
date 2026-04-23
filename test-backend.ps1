$BASE = "http://localhost:8080"

function CallAPI {
    param($method, $path, $body, $token)
    $h = @{ "Content-Type" = "application/json" }
    if ($token) { $h["Authorization"] = "Bearer $token" }
    $p = @{ Uri = "$BASE$path"; Method = $method; Headers = $h }
    if ($body) { $p["Body"] = ($body | ConvertTo-Json -Compress) }
    try { return Invoke-RestMethod @p }
    catch { return [PSCustomObject]@{ __error = $_.ErrorDetails.Message } }
}

Write-Host "`n1. SIGNUP admin" -ForegroundColor Cyan
$r = CallAPI POST "/api/auth/signup" @{username="admin_user";email="admin@campus.com";password="password123";role=@("admin")}
if ($r.message) { Write-Host "  OK: $($r.message)" -ForegroundColor Green }
else { Write-Host "  SKIP: $($r.__error)" -ForegroundColor Yellow }

Write-Host "`n2. LOGIN admin" -ForegroundColor Cyan
$r = CallAPI POST "/api/auth/signin" @{username="admin_user";password="password123"}
if (!$r.token) { Write-Host "  FAIL: $($r.__error)" -ForegroundColor Red; exit }
$adminToken = $r.token
Write-Host "  OK: $($r.username) | $($r.roles)" -ForegroundColor Green

Write-Host "`n3. CREATE EVENT" -ForegroundColor Cyan
$eb = @{title="Spring Tech Fest";description="Annual tech festival";location="Auditorium";dateTime="2026-06-15T09:00:00";category="Technology";capacity=500}
$r = CallAPI POST "/api/events" $eb $adminToken
if ($r.message) { Write-Host "  OK: $($r.message)" -ForegroundColor Green }
else { Write-Host "  FAIL: $($r.__error)" -ForegroundColor Red }

Write-Host "`n4. GET ALL EVENTS" -ForegroundColor Cyan
$events = CallAPI GET "/api/events" $null $adminToken
if ($events.__error) { Write-Host "  FAIL: $($events.__error)" -ForegroundColor Red }
else {
    Write-Host "  OK: $($events.Count) event(s)" -ForegroundColor Green
    $events | ForEach-Object { Write-Host "    [$($_.id)] $($_.title)" }
}

Write-Host "`n5. SIGNUP student" -ForegroundColor Cyan
$r = CallAPI POST "/api/auth/signup" @{username="student1";email="student1@campus.com";password="pass1234";role=@("user")}
if ($r.message) { Write-Host "  OK: $($r.message)" -ForegroundColor Green }
else { Write-Host "  SKIP: $($r.__error)" -ForegroundColor Yellow }

Write-Host "`n6. LOGIN student" -ForegroundColor Cyan
$r = CallAPI POST "/api/auth/signin" @{username="student1";password="pass1234"}
if (!$r.token) { Write-Host "  FAIL: $($r.__error)" -ForegroundColor Red; exit }
$stuToken = $r.token
Write-Host "  OK: $($r.username) | $($r.roles)" -ForegroundColor Green

Write-Host "`n7. REGISTER FOR EVENT" -ForegroundColor Cyan
if ($events -and $events.Count -gt 0) {
    $eid = $events[0].id
    $r = CallAPI POST "/api/events/$eid/register" $null $stuToken
    if ($r.message) { Write-Host "  OK: $($r.message)" -ForegroundColor Green }
    else { Write-Host "  INFO: $($r.__error)" -ForegroundColor Yellow }
} else { Write-Host "  SKIP: No events" -ForegroundColor Yellow }

Write-Host "`n8. MY REGISTRATIONS" -ForegroundColor Cyan
$r = CallAPI GET "/api/events/my-registrations" $null $stuToken
if ($r.__error) { Write-Host "  FAIL: $($r.__error)" -ForegroundColor Red }
else { Write-Host "  OK: $($r.Count) registration(s)" -ForegroundColor Green }

Write-Host "`n9. H2 CONSOLE" -ForegroundColor Cyan
try {
    $h2 = Invoke-WebRequest -Uri "$BASE/h2-console" -UseBasicParsing
    Write-Host "  OK: HTTP $($h2.StatusCode)" -ForegroundColor Green
} catch { Write-Host "  FAIL" -ForegroundColor Red }

Write-Host "`n=== DONE ===" -ForegroundColor Cyan
