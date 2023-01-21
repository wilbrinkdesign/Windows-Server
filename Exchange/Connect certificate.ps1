Get-ExchangeCertificate
Get-SendConnector

Get-ReceiveConnector | where {$_.TlsCertificateName}

$cert = Get-ExchangeCertificate -Thumbprint "06556899323423656653453454555789"
$tls = "<i>$($cert.Issuer)<s>$($cert.Subject)"
Set-ReceiveConnector "Default Frontend Server01" -TlsCertificateName $tls
Set-SendConnector "Send Connector buiten" -TlsCertificateName $tls
Restart-Service MSExchangeTransport
