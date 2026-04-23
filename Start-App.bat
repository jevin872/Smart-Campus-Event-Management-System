@echo off
echo Starting Smart Campus Event Management System...

echo Starting Spring Boot Backend on http://localhost:8080...
start cmd /k "cd backend && .\mvnw.cmd spring-boot:run"

echo Starting React Frontend on http://localhost:5173...
start cmd /k "cd frontend && npm run dev"

echo.
echo Both servers are starting! 
echo Keep these terminal windows open.
pause
