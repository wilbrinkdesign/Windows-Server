### Get all certificates

```powershell
Get-ExchangeCertificate
```

### Get connectors with certificate

```powershell
Get-SendConnector | where {$_.TlsCertificateName}
Get-ReceiveConnector | where {$_.TlsCertificateName}
```

### Activate certificate on connector

```powershell
$cert = Get-ExchangeCertificate -Thumbprint <thumbprint>
$tls = "<i>$($cert.Issuer)<s>$($cert.Subject)"
Set-SendConnector "<connector>" -TlsCertificateName $tls
Restart-Service MSExchangeTransport
```

### Restart Transport service after activating certificate

```powershell
Restart-Service MSExchangeTransport
```
