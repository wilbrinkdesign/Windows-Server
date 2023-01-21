ECHO Check Activation Status
slmgr /xpr

ECHO View Current License Info
slmgr /dli

ECHO View Detailed License Info
slmgr /dlv

ECHO Reset Activation Timers
slmgr /rearm

ECHO Remove Windows Product Key
slmgr /cpky

ECHO Activate Windows Online
slmgr /ato

ECHO Change Windows Product Key
slmgr /ipk <key>

ECHO Deactivate Windows
slmgr /upk

ECHO Register with KMS Server/Domain
slmgr /skms <server>
slmgr /skms-domain <domain>

ECHO Get License Info from Cmd
cscript C:\windows\system32\slmgr.vbs /dlv
