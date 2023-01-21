# Map drive maken
$ww = "" | ConvertTo-SecureString -AsPlainText -Force
$cred = New-Object System.Management.Automation.PsCredential('SERVER\USER',$ww)
New-PSDrive -name Z -Root "PAD" -Credential $cred -PSProvider filesystem