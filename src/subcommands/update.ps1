Write-Host "Updating CLI"

$currentTagRevision = git -C "$PSScriptRoot\..\.." rev-list --tags --max-count=1
$currentTagVersion = git -C "$PSScriptRoot\..\.." describe --tags $currentTagRevision

git -C "$PSScriptRoot\..\.." fetch --all --tags --quiet

$newTagRevision = git -C "$PSScriptRoot\..\.." rev-list --tags --max-count=1
$newTagVersion = git -C "$PSScriptRoot\..\.." describe --tags $newTagRevision

if ($currentTagVersion -eq $newTagVersion) {
    Write-Host "There is no update available"
}
else {
    $confirmation = Read-Host "A new version $newTagVersion is available, do you want to update now [Y/n]?"
    if ($confirmation -eq "y") {
        git -C "$PSScriptRoot\..\.." pull --quiet
        Write-Host "Update to $newTagVersion version was successfull!"
    }
}
