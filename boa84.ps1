# BOA84 boa84.ps1 - Windows PowerShell - AUTO-PILOT
Write-Host "BOA84 AUTO-PILOT - Windows - Starting..."
Set-Location "$HOME\potential-octo-garbanzo" -ErrorAction SilentlyContinue
.\autoexec.bat
# NS SYNC - PowerShell version
foreach ($ns in @("ns_OneEyeMail","ns_HOLLA","ns_BOA84")) {
  Get-ChildItem -Recurse -Filter "main.*" | Where-Object { $_.FullName -notmatch "\.git" } | ForEach-Object {
    $target = Join-Path $_.DirectoryName "$($ns)_$($_.Name)"
    if (-not (Test-Path $target)) { Copy-Item $_.FullName $target; Write-Host "AUTO $target" }
  }
}
if (git status --porcelain) {
  git add -A; git commit -m "AUTO-PILOT Windows - $(Get-Date -Format 'yyyy-MM-dd HH:mm')"; git pull --rebase; git push origin HEAD
  Write-Host "BOA84 AUTO-PILOT - PUSHED - OK"
} else { Write-Host "BOA84 AUTO-PILOT - Nothing new - OK" }
