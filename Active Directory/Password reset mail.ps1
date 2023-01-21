######################################################################
# Script: PasswordExpiresMail.ps1
# Versie: 2.3
# Auteur: Mark Wilbrink
# Datum: December 2021
#
# Omschrijving: Collega's mailen zodra hun wachtwoord verloopt
######################################################################

# Logging aan
Start-Transcript -Path "${PSCommandPath}.log" | Out-Null

# Modules
Import-Module ActiveDirectory

# Vars
$debug = 0 # Standaard = 0
$notificationstartday = 7, 3, 1 # Herinneringsmail op de 7e, 3e en laatste dag
$sendermailaddress = ""
$SMTPserver = ""
$DN = ""

# Password policy GPO
$domainPolicy = Get-ADDefaultDomainPasswordPolicy
$passwordexpirydefaultdomainpolicy = $domainPolicy.MaxPasswordAge.Days -ne 0
$defaultdomainpolicyMaxPasswordAge = $domainPolicy.MaxPasswordAge.Days

# Mailen
foreach ($user in (Get-ADUser -SearchBase $DN -Filter * -properties mail, passwordneverexpires, extensionAttribute3 | Where { $_.passwordNeverExpires -eq $False } | Where { $_.enabled -eq $True } | Where { $_.mail -gt '' }))
{
    $samaccountname = $user.samaccountname

    if($passwordexpirydefaultdomainpolicy)
    {
        $pwdlastset = [datetime]::FromFileTime((Get-ADUser -LDAPFilter "(&(samaccountname=$samaccountname))" -properties pwdLastSet).pwdLastSet)
        $expirydate = ($pwdlastset).AddDays($defaultdomainpolicyMaxPasswordAge)
        $delta = ($expirydate - (Get-Date)).Days
        $comparionresults = $notificationstartday -Contains ($expirydate - (Get-Date)).Days -And ($delta -ge 1)
        if ($comparionresults)
        {
            $usermailaddress = if ($user.extensionAttribute3) { $user.extensionAttribute3 } else { $user.mail }
            $office365mail = $user.mail

            $mailBody = "Beste " + $user.GivenName + ",<br><br>"
            $delta = ($expirydate - (Get-Date)).Days
            $mailBody += "Je wachtwoord voor account '$office365mail' verloopt over " + $delta + " dag(en). Vergeet het niet voor die tijd te wijzigen!<br><br>"

            $mailBody += "Je wachtwoord kun je op de volgende manier wijzigen.<br><br>"

            $mailBody += "<b>Hybride laptop:</b><br>"
            $mailBody += "- Op kantoor: CTRL + ALT + DEL -> Wachtwoord wijzigen<br>"
            $mailBody += "- Thuis of extern: Zorg dat de VPN (het stoplichtje) aanstaat, vervolgens CTRL + ALT + DEL -> Wachtwoord wijzigen<br><br>"

            $mailBody += "<b>Mobiele telefoon:</b><br>"
            $mailBody += "- Bedrijfsportal: Download de app Wachtwoord wijzigen of open Microsoft Edge en ga naar https://portal.office.com -> Rechtsboven profiel foto -> Account weergeven -> Wachtwoord wijzigen<br><br>"

            $mailBody += "Vriendelijke groet,<br>"
            $mailBody += "ServiceDesk"
            
            if ($debug -gt 0)
            {
                Write-Host "Debug: $mailBody`r`n"
            }
            else
            {
                Write-Host "E-mail: $mailBody`r`n"
                Send-MailMessage -To $usermailaddress -From $sendermailaddress -Body $mailBody -BodyAsHtml -Subject "Je wachtwoord verloopt binnenkort" -Encoding UTF8 -SmtpServer $SMTPserver
            }
        }
    }
}

# Logging uit
Stop-Transcript | Out-Null