Write-Host "Updating CLI"

$currentTagRevision = git -C "$PSScriptRoot\..\.." rev-list --tags --max-count=1
$currentTagVersion = git -C "$PSScriptRoot\..\.." describe --tags $currentTagRevision

git -C "$PSScriptRoot\..\.." fetch --all --tags

$newTagRevision = git -C "$PSScriptRoot\..\.." rev-list --tags --max-count=1
$newTagVersion = git -C "$PSScriptRoot\..\.." describe --tags $newTagRevision

if ($currentTagVersion -eq $newTagVersion) {
    Write-Host "There is not update"
}
else {
    git -C "$PSScriptRoot\..\.." pull
    Write-Host "Update is successfull"
}
