### Empty attribute

```powershell
Get-ADUser -Properties info | Set-ADuser -Clear info
```

### Fill attribute with existing attribute

```powershell
Get-ADUser -Filter {telephonenumber -like "<tel>*"} -Properties * | Foreach-object { 
	Set-ADuser -identity $_ -replace @{ipphone="$($_.telephonenumber.substring(8,3))"} 
}
```

### Edit AD users with specific department

```powershell
Get-ADUser -Filter {department -like "<department_old>"} | Foreach-object { Set-ADUser -Identity $_.SamAccountName -department "<department_new>" }
```
