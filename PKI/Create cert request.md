### Example inf file

```inf
[Version]
Signature="$Windows NT$"

[NewRequest]
Subject = "C=NL, O=Company, CN=domain.com"
KeySpec = 1
KeyLength = 2048
Exportable = TRUE
MachineKeySet = TRUE
SMIME = False
PrivateKeyArchive = FALSE
UserProtected = FALSE
UseExistingKeySet = FALSE
ProviderName = "Microsoft RSA SChannel Cryptographic Provider"
ProviderType = 12
RequestType = PKCS10
KeyUsage = 0xa0

[Extensions]
2.5.29.17 = "{text}"
_continue_ = "dns=test1.company.com&"
_continue_ = "dns=test2.company.com&"
_continue_ = "ipaddress=192.168.1.1"
```

### Create certificate request (CSR)

```cmd
REM Run as Administrator
certreq -new <inf_file> <csr_file>
```