############  Instructions to Run this script ###################
# Before executing this script Run the command in line number 3 without Hash
# Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned
$executionPolicy = Get-ExecutionPolicy -Scope Process
if ($executionPolicy -eq "RemoteSigned") {
    New-Item -Type Directory -Path "C:\HWID"
    Set-Location -Path "C:\HWID"
    $env:Path += ";C:\Program Files\WindowsPowerShell\Scripts"
    Install-Script -Name Get-WindowsAutopilotInfo -Force -Confirm:$False
    Get-WindowsAutopilotInfo -OutputFile AutopilotHWID.csv
    $serial = (Import-Csv C:\HWID\AutoPilotHWID.csv).'Device Serial Number' | Select-Object -First 1
    Rename-Item -LiteralPath C:\HWID\AutoPilotHWID.csv -NewName ($serial + '-AutoPilotHWID.csv')
}
else {
    Write-Host "Please Change the policy to Remote Signed with below command"
    Write-Host "'Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned'" -ForegroundColor Cyan
}
