### Check Activation Status

```cmd
slmgr /xpr
```

### View Current License Info

```cmd
slmgr /dli
```

### View Detailed License Info

```cmd
slmgr /dlv
```

### Reset Activation Timers

```cmd
slmgr /rearm
```

### Remove Windows Product Key

```cmd
slmgr /cpky
```

### Activate Windows Online

```cmd
slmgr /ato
```

### Change Windows Product Key

```cmd
slmgr /ipk <key>
```

### Deactivate Windows

```cmd
slmgr /upk
```

### Register with KMS Server/Domain

```cmd
slmgr /skms <server>
slmgr /skms-domain <domain>
```

### Get License Info from Cmd

```cmd
cscript C:\windows\system32\slmgr.vbs /dlv
```
