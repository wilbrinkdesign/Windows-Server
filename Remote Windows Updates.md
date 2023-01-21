### CSV file

```csv
<server1>
<server2>
```

### PSWindowsUpdate module is required for Server 2012 servers

PowerShell module: [PSWindowsUpdates](https://www.powershellgallery.com/packages/PSWindowsUpdate)

### Script 4 remote PowerShell Windows Updates

```powershell
Import-Csv .\Servers.txt -Header Server | ForEach-Object {
	Invoke-Command -ComputerName $_.Server -ScriptBlock {     
		$Computername = $env:COMPUTERNAME
		$OS_Versie = [System.Environment]::OSVersion.Version.Build

		If ($OS_Versie -ge 14393)
		{
			Write-Host "$Computername (build: $OS_Versie) wordt nu bijgewerkt: usoclient startinstall" -ForegroundColor Green
			usoclient startinstall
		}
		Else
		{
			Write-Host "$Computername (build: $OS_Versie) wordt nu bijgewerkt: wuauclt /detectnow /updatenow" -ForegroundColor Green
			Import-Module PSWindowsUpdate
			Get-WindowsUpdate -AcceptAll -Install -IgnoreReboot
		}
	} -AsJob
}
```
