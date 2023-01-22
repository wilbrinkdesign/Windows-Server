### Set product code and server edition

```powershell
dism /online /set-edition:serverstandard /productkey:<code> /accepteula
shutdown -r -t 0
```

### Set product code and activate

```powershell
slmgr /ipk <code>
slmgr /ato
```
