### Get current visitors from a specific site

```powershell
Get-Counter "\\<server>\web service(<website>)\current connections"
```

### Get all current visitors

```powershell
Get-Counter 'web service(_total)\current connections' -ComputerName $env:COMPUTERNAME
```