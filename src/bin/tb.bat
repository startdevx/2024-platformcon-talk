@echo OFF

set current_location=%~dp0
set arguments=%*

powershell -NoProfile -ExecutionPolicy bypass -File "%current_location%tb.ps1" %arguments%
