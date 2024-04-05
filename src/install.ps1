$currentPath = [System.Environment]::GetEnvironmentVariable("PATH", "User")

$cliSubPath = $PSScriptRoot + "\bin"
$subPaths = $currentPath.Split(";")

if (-not ($subPaths -Contains $cliSubPath)) {
    $newPath = $currentPath + ";" + $cliSubPath
    [System.Environment]::SetEnvironmentVariable("PATH", $newPath, "User")
}

Write-Host "Congratulations! The CLI 'tb' has been installed."
Read-Host "Press any key to continue"