# Vraag alle versies van de ISO
dism /Get-WimInfo /WimFile:install.wim

# Maak een export van de ISO
dism /export-image /SourceImageFile:D:\sources\sxs\install.wim /SourceIndex:5 /DestinationImageFile:C:\Temp\install.wim /Compress:max /CheckIntegrity

# Inject drivers
dism /Mount-Wim /WimFile:C:\Mount\boot.wim /Index:1 /MountDir:C:\Mount\BootWIM
dism /Image:C:\Mount\BootWIM /Add-Driver /Driver:C:\Mount\Drivers /recurse
dism /Unmount-Wim /MountDir:C:\Mount\BootWIM /Commit

# Windows Updates toevoegen
dism /mount-wim /wimfile:C:\Mount\boot.wim /Index:1 /mountdir:C:\Mount\BootWIM
dism /image:C:\Mount\BootWIM /Add-Package /PackagePath:"D:\Windows Updates"
dism /Unmount-wim /mountdir:C:\Mount\BootWIM /commit
