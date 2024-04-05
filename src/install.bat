@echo OFF

set current_location=%~dp0

powershell "Get-ChildItem -Path '%current_location%*.ps1' -Recurse | Unblock-File"
powershell -NoProfile -ExecutionPolicy bypass -File "%current_location%install.ps1"