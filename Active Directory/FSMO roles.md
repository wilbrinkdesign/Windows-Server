### Get FSMO roles

```cmd
netdom query fsmo
```

### Move FSMO roles

```powershell
# Gracefully
Move-ADDirectoryServerOperationMasterRole -Identity NewDC -OperationMasterRole 0,1,2,3,4

# Seize
Move-ADDirectoryServerOperationMasterRole -Identity NewDC -OperationMasterRole 0,1,2,3,4 -Force
```