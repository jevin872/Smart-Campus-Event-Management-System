@echo off
echo === 1. SIGNUP admin ===
curl.exe -s -X POST http://localhost:8080/api/auth/signup -H "Content-Type: application/json" -d "{\"username\":\"admin_user\",\"email\":\"admin@campus.com\",\"password\":\"password123\",\"role\":[\"admin\"]}"
echo.

echo === 2. LOGIN admin ===
curl.exe -s -X POST http://localhost:8080/api/auth/signin -H "Content-Type: application/json" -d "{\"username\":\"admin_user\",\"password\":\"password123\"}" -o login_response.json
type login_response.json
echo.

echo === 3. Extract token and test GET events ===
for /f "tokens=2 delims=:," %%a in ('findstr /i "token" login_response.json') do (
    set RAW_TOKEN=%%a
)
echo Raw token extracted
