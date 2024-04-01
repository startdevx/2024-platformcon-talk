function Show-Help {
    Write-Host "To get help, execute the following command:"
    Write-Host "    tbox help"
}

if (-not $args) {
    Show-Help
    exit 0
}

$argumentsArray = $args.Split(" ")
$command, $arguments = $argumentsArray

switch -CaseSensitive ($command) {
    "help" { ."$PSScriptRoot\subcommands\help.ps1" }
    "update" { ."$PSScriptRoot\subcommands\update.ps1" }
    default {
        Show-Help
    }
}