function Write-Help {
    Write-Host "The given subcommand is not found."
}

if (-not $args) {
    Write-Help
    exit 0
}

$arguments = $args.Split(" ")
$subCommand, $options = $arguments

switch -CaseSensitive ($subCommand) {
    "update" { ."$PSScriptRoot\subcommands\update.ps1" $options }
    default {
        Write-Help
    }
}