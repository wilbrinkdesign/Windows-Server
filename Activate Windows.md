### Set product code and server edition

```powershell
dism /online /Set-Edition:ServerDatacenter /ProductKey:<code> /AcceptEula
```

### Set product code and activate

```powershell
cscript C:\Windows\System32\slmgr.vbs /ipk <code>
cscript C:\Windows\System32\slmgr.vbs /ato
```

### Script to activate different types of Windows OS with KMS

```powershell
$Versie = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion").ProductName

$Keys = @{
	"Windows Server 2012 R2 Standard" = "D2N9P-3P6X9-2R39C-7RTCD-MDVJX"
	"Windows Server 2016 Standard" = "WC2BQ-8NRM3-FDDYY-2BFGV-KHKQY"
	"Windows Server 2019 Standard" = "N69G4-B89J2-4G8F4-WWYCC-J464C"
	"Windows Server 2022 Standard" = "VDYBN-27WPP-V4HQT-9VMD4-VMK7H"
}

If (($Keys[$Versie] | Measure-Object -Character).Characters -eq 29)
{
	If ((Get-WmiObject -Class Win32_ComputerSystem).PartOfDomain -eq $True) # Domain joined server
	{
		Write-Host "Windows versie: $Versie, Type: Domain, Key: $($Keys[$Versie]), installeren..." -ForegroundColor Yellow
		cscript C:\Windows\System32\slmgr.vbs /ckms
		cscript C:\Windows\System32\slmgr.vbs /ckms-domain
		cscript C:\Windows\System32\slmgr.vbs /ipk $Keys[$Versie]
	}
	Else # DMZ server
	{
		Write-Host "Windows versie: $Versie, Type: DMZ, Key: $($Keys[$Versie]), installeren..." -ForegroundColor Yellow
		cscript C:\Windows\System32\slmgr.vbs /skms <kms:port>
		cscript C:\Windows\System32\slmgr.vbs /ipk $Keys[$Versie]
	}

	cscript C:\Windows\System32\slmgr.vbs /ato
}
Else
{
	Write-Host "Key niet gevonden! Windows versie: $Versie" -ForegroundColor Red
}
```