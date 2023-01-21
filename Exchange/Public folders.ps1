Get-OrganizationConfig | fl publicfoldersenabled
New-Mailbox -PublicFolder -Name MasterHierachy

Add-PublicFolderClientPermission "\Folder1\Adresboek1" -User "AD_GROEP" -AccessRights Reviewer
Get-PublicFolder "\Folder1\Adresboek1" | Get-PublicFolderClientPermission

Verdere permissies in orde maken? Open Outlook client en pas daar de machtigingen aan.
