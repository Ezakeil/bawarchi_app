# Create directories
New-Item -ItemType Directory -Force -Path app/api/v1/endpoints
New-Item -ItemType Directory -Force -Path app/core
New-Item -ItemType Directory -Force -Path app/services
New-Item -ItemType Directory -Force -Path app/models

# Create files
New-Item -ItemType File -Force -Path app/api/v1/router.py
New-Item -ItemType File -Force -Path app/core/config.py
New-Item -ItemType File -Force -Path app/core/security.py
New-Item -ItemType File -Force -Path app/__init__.py
New-Item -ItemType File -Force -Path app/main.py

Write-Host "FastAPI project structure created successfully in 'app/' folder."
