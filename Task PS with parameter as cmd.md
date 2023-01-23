### Task Schedular with PowerShell and a parameter

```powershell
powershell.exe -Command "&{ Get-ChildItem IIS:\AppPools | Where-Object State -eq "Stopped" | Start-WebAppPool }"
```
