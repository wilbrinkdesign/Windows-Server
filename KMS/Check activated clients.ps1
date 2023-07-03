$(foreach ($entry in (Get-EventLog -Logname "Key Management Service")) {$entry.ReplacementStrings[3]}) | sort-object -Unique
