[Get a free certificate](https://getacert.com/signacert.html)

### Create certificate request (CSR)

```powershell
$Password = "<password>"
certutil -p "$Password,$Password" -mergepfx <cert_file> <pfx_file>
$PFX = Get-ChildItem -Path <pfx_file> | Import-PfxCertificate -CertStoreLocation Cert:\LocalMachine\My -Exportable -Password ($Password | ConvertTo-SecureString -AsPlainText -Force)
Get-ChildItem -Path "Cert:\LocalMachine\My\$($PFX.Thumbprint)" | Export-PfxCertificate -FilePath <pfx_file> -Password ($Password | ConvertTo-SecureString -AsPlainText -Force)
```