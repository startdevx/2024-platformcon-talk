Write-Host "Checking if new version is available" -ForegroundColor White

git -C "$PSScriptRoot\..\.." fetch --all --tags --quiet

$currentTagRevision = git -C "$PSScriptRoot\..\.." rev-parse --verify HEAD
$newTagRevision = git -C "$PSScriptRoot\..\.." rev-list --tags --max-count=1

$currentTagVersion = git -C "$PSScriptRoot\..\.." describe --tags $currentTagRevision
$newTagVersion = git -C "$PSScriptRoot\..\.." describe --tags $newTagRevision

if ($currentTagVersion -eq $newTagVersion) {
    Write-Host "No update is available"
}
else {
    $confirmation = Read-Host "A new version $newTagVersion is available, do you want to update now [Y/n]?"
    if ($confirmation -eq "y") {
        git -C "$PSScriptRoot\..\.." pull --quiet
        Write-Host "Version $newTagVersion was installed successfully!"
    }
}
