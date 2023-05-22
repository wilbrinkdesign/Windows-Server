### Create scheduled task with PS script and run as SYSTEM

```powershell
$Action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-ExecutionPolicy Bypass `"<script.ps1>`""
$Trigger = New-ScheduledTaskTrigger -Daily -At 11PM
$User = New-ScheduledTaskPrincipal -UserID "NT AUTHORITY\SYSTEM" -LogonType ServiceAccount
$Task = New-ScheduledTask -Description "<description>" -Action $Action -Principal $User -Trigger $Trigger
Register-ScheduledTask "<name>" -InputObject $Task
```