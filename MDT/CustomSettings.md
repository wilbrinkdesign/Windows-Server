### Example of a customsettings.ini file

```ini
[Settings]
Priority=MACAddress,Model,Make,Default
Properties=MyCustomProperty

[LENOVO]
OSDComputerName=LT-%SerialNumber%
SkipComputerName=YES
SkipTaskSequence=YES
TaskSequenceID=DEFAULT

[Default]
OSInstall=Y
SkipTaskSequence=NO
SkipCapture=YES
SkipAdminPassword=YES
SkipProductKey=YES
SkipComputerBackup=YES
SkipBitLocker=YES
SkipDomainMembership=YES
SkipApplications=YES
SkipLocaleSelection=YES
SkipTimeZone=YES
SkipUserData=YES
SkipSummary=YES
SkipComputerName=NO
OSDComputerName=<prefix>-
SLShare=\\<server>\DeploymentShare$\Logs
SLShareDynamicLogging=\\<server>\DeploymentShare$\Logs
TimeZone=110
TimeZoneName=W. Europe Standard Time
KeyboardLocale=nl-nl;0413:00020409
UILanguage=nl-nl
UserLocale=nl-nl
AreaCode=070
CountryCode=031
WUMU_ExcludeKB001=2267602
```
