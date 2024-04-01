@echo OFF

set current_location=%~dp0
set command=%*

powershell -NoProfile -ExecutionPolicy bypass -File "%current_location%tbox.ps1" %command%
