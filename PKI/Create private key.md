### Create private key

```powershell
$Cert = Get-ChildItem Cert:\LocalMachine\REQUEST\ -Recurse | Where-Object { $_.Subject -like "*<domain>*" -and (Get-Date $_.NotBefore -Format "yyyy-MM-dd") -eq (Get-Date -Format "yyyy-MM-dd") }
$RSACng = [System.Security.Cryptography.X509Certificates.RSACertificateExtensions]::GetRSAPrivateKey($Cert)
$KeyBytes = $RSACng.Key.Export([System.Security.Cryptography.CngKeyBlobFormat]::Pkcs8PrivateBlob)
$KeyBase64 = [System.Convert]::ToBase64String($KeyBytes, [System.Base64FormattingOptions]::InsertLineBreaks)
$KeyPem = @"
-----BEGIN PRIVATE KEY-----
$KeyBase64
-----END PRIVATE KEY-----
"@
$KeyPem | Out-File <key_file>
$Cert | Remove-Item
```