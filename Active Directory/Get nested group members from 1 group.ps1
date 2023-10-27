function Get-NestedADGroup {
    Param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [Alias('Group')]
        # any of Name, DistinguishedName, objectGUID, objectSid, sAMAccountName
        [string]$Identity,

        # optional parameters
        [string[]]$Properties = @(),
        [string]$Server = $null,

        [Parameter(Mandatory = $false)]
        # This allows you to pass in a username as a string and have an interactive prompt for the password
        [System.Management.Automation.Credential()]
        [System.Management.Automation.PSCredential]$Credential = [System.Management.Automation.PSCredential]::Empty
    )

    # Get-ADGroup by default returns properties DistinguishedName, GroupCategory, GroupScope, Name, ObjectClass, 
    # ObjectGUID, SamAccountName, SID. This function always adds property Members to that.
    # (PowerShell property name: Members; LDAP attribute name: member)
    $params = @{
        Identity   = $Identity
        Properties = @($Properties) + 'Members' | Sort-Object -Unique  
    }  
    if (![string]::IsNullOrWhiteSpace($Server)) { $params['Server'] = $Server }
    if (($Credential) -and $Credential -ne [System.Management.Automation.PSCredential]::Empty) {
        $params['Credential'] = $Credential
    }

    # try and get the group object from AD
    $adGroup = Get-ADGroup @params -ErrorAction SilentlyContinue
    if ($adGroup) {
        if (-not $script:groupsHash.ContainsKey($adGroup.DistinguishedName)) {
            # output this group object
            $adGroup
            # add the DistinguishedName of this group to the hash to prevent circular references
            $script:groupsHash[$adGroup.DistinguishedName] = $true
            # loop through the groups Members collection (all DistinguishedNames)
            foreach ($member in $adGroup.Members){
                $params['Identity'] = $member  # reuse the params Hashtable
                $params.Remove('Properties')   # remove Properties from the Hashtable for Get-ADObject
                $memberObject = Get-ADObject @params -ErrorAction SilentlyContinue
                if (($memberObject) -and $memberObject.objectClass -eq 'group') {
                    # recurse to get the nested groups
                    $params['Properties'] = $Properties  # add the Properties to the Hashtable again
                    Get-NestedADGroup @params
                }
            }
        }
    }
    else {
        Write-Warning "Group '$($Identity)' could not be found.."
    }
}

# create a Hashtable to avoid circular nested groups
$groupsHash = @{}

# call the function
$result = Get-NestedADGroup -Group '<name>'

# output just the names
$result.Name