$BASE = "http://localhost:8080"

# Write JSON bodies to temp files
'{"username":"admin_user","email":"admin@campus.com","password":"password123","role":["admin"]}' | Out-File -Encoding utf8 -FilePath signup_admin.json
'{"username":"admin_user","password":"password123"}' | Out-File -Encoding utf8 -FilePath login_admin.json
'{"title":"Spring Tech Fest","description":"Annual tech festival","location":"Auditorium","dateTime":"2026-06-15T09:00:00","category":"Technology","capacity":500}' | Out-File -Encoding utf8 -FilePath event_body.json
'{"username":"student1","email":"student1@campus.com","password":"pass1234","role":["user"]}' | Out-File -Encoding utf8 -FilePath signup_student.json
'{"username":"student1","password":"pass1234"}' | Out-File -Encoding utf8 -FilePath login_student.json

Write-Host "`n1. SIGNUP admin" -ForegroundColor Cyan
& curl.exe -s -X POST "$BASE/api/auth/signup" -H "Content-Type: application/json" -d "@signup_admin.json"
Write-Host ""

Write-Host "`n2. LOGIN admin" -ForegroundColor Cyan
$loginJson = & curl.exe -s -X POST "$BASE/api/auth/signin" -H "Content-Type: application/json" -d "@login_admin.json"
Write-Host $loginJson
$loginObj = $loginJson | ConvertFrom-Json
$TOKEN = $loginObj.token
Write-Host "Token: $($TOKEN.Substring(0,20))..." -ForegroundColor Green

Write-Host "`n3. CREATE EVENT" -ForegroundColor Cyan
& curl.exe -s -X POST "$BASE/api/events" -H "Content-Type: application/json" -H "Authorization: Bearer $TOKEN" -d "@event_body.json"
Write-Host ""

Write-Host "`n4. GET ALL EVENTS" -ForegroundColor Cyan
$eventsJson = & curl.exe -v -X GET "$BASE/api/events" -H "Authorization: Bearer $TOKEN" 2>&1
Write-Host ($eventsJson | Where-Object { $_ -notmatch "^\*" } | Out-String)

Write-Host "`n5. SIGNUP student" -ForegroundColor Cyan
& curl.exe -s -X POST "$BASE/api/auth/signup" -H "Content-Type: application/json" -d "@signup_student.json"
Write-Host ""

Write-Host "`n6. LOGIN student" -ForegroundColor Cyan
$stuJson = & curl.exe -s -X POST "$BASE/api/auth/signin" -H "Content-Type: application/json" -d "@login_student.json"
Write-Host $stuJson
$stuObj = $stuJson | ConvertFrom-Json
$STU_TOKEN = $stuObj.token

if ($events -and $events.Count -gt 0) {
    $eid = $events[0].id
    Write-Host "`n7. REGISTER FOR EVENT (id=$eid)" -ForegroundColor Cyan
    & curl.exe -s -X POST "$BASE/api/events/$eid/register" -H "Authorization: Bearer $STU_TOKEN"
    Write-Host ""

    Write-Host "`n8. MY REGISTRATIONS" -ForegroundColor Cyan
    & curl.exe -s -X GET "$BASE/api/events/my-registrations" -H "Authorization: Bearer $STU_TOKEN"
    Write-Host ""
} else {
    Write-Host "SKIP: No events returned" -ForegroundColor Yellow
}

Write-Host "`n9. H2 CONSOLE" -ForegroundColor Cyan
$h2 = & curl.exe -s -o NUL -w "%{http_code}" "$BASE/h2-console"
Write-Host "HTTP $h2" -ForegroundColor Green

# Cleanup
Remove-Item signup_admin.json, login_admin.json, event_body.json, signup_student.json, login_student.json -ErrorAction SilentlyContinue

Write-Host "`n=== DONE ===" -ForegroundColor Cyan
