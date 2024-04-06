function Send-ReleaseNote($releaseVersion) {
    $secureString = ConvertTo-SecureString $Env:PT_PWD -AsPlainText -Force
    $credential = New-Object System.Management.Automation.PSCredential ($Env:PT_USER, $secureString)

    $releaseNoteContent = Get-Content "$PSScriptRoot\..\RELEASE_NOTE.md"
    $releasenote = $releaseNoteContent -join "<br>"

    $sendMailMessageArguments = @{
        From       = "kevin@startdevx.com"
        To         = "$Env:USERNAME@devwithkev.com"
        Subject    = "CLI Release Note $releaseVersion"
        Body       = $releaseNote
        BodyAsHtml = $True
        SmtpServer = "127.0.0.1"
        Port       = "1025"
        Credential = $credential
    }

    Write-Host "Sending release notes to your email address..."
    Send-MailMessage @sendMailMessageArguments
}

Write-Host "Checking if new version is available" -ForegroundColor White

git -C "$PSScriptRoot\..\.." fetch --prune --prune-tags --all --tags --quiet

$currentTagRevision = git -C "$PSScriptRoot\..\.." rev-parse --verify HEAD
$newTagRevision = git -C "$PSScriptRoot\..\.." rev-list --tags --max-count=1

$currentTagVersion = git -C "$PSScriptRoot\..\.." describe --tags $currentTagRevision
$newTagVersion = git -C "$PSScriptRoot\..\.." describe --tags $newTagRevision

if ($currentTagVersion -eq $newTagVersion) {
    Write-Host "No update is available!"
}
else {
    $confirmation = Read-Host "A new version $newTagVersion is available, do you want to update now [Y/n]?"
    if ($confirmation -eq "y") {
        git -C "$PSScriptRoot\..\.." pull --quiet
        Write-Host "Version $newTagVersion was installed successfully!"
        Send-ReleaseNote $newTagVersion
    }
}

exit 0