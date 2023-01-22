### Check activation status

```cmd
slmgr /xpr
```

### View current license info

```cmd
slmgr /dli
```

### View detailed license info

```cmd
slmgr /dlv
```

### Reset activation timers

```cmd
slmgr /rearm
```

### Remove Windows product key

```cmd
slmgr /cpky
```

### Activate Windows online

```cmd
slmgr /ato
```

### Change Windows product key

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

### Get license info from cmd

```cmd
cscript C:\windows\system32\slmgr.vbs /dlv
```
