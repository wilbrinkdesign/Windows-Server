forfiles -p C:\inetpub\logs\LogFiles\ -s -m *.log -d -180 -c "cmd /C DEL @File"