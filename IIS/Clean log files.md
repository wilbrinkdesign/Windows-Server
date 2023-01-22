### Clean IIS log files

```powershell
forfiles -p <inetpub_dir>\logs\LogFiles\ -s -m *.log -d -180 -c "cmd /C DEL @File"
```