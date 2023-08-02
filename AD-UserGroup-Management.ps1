$fileinput = Get-ChildItem -Path (read-host "Please enter file path")

$xml = [xml](Get-Content $fileinput)

$users = $xml.root.user

foreach ($user in $users)
{
    Write-Host "Adding User:" $user.firstname $user.lastname

    $ou = $user.ou
    Write-Host "To Group:" $ou

    $domain = Get-ADDomain

    $dn = $domain.DistinguishedName

    $ouexist = Get-ADOrganizationalUnit -Filter {name -eq $ou}

    if ($null -eq $ouexist)
    {
        New-ADOrganizationalUnit -Name $ou -Path $dn
    }
    
    $pass = $user.password
    $secpass = ConvertTo-SecureString -AsPlainText $pass -Force

    New-ADUser -Name $user.account -Path "OU=$ou,$dn" -Surname $user.lastname -AccountPassword $secpass -Description $user.description -Enabled 1
    
    $groups = $user.memberOf.group

    foreach($group in $groups) 
    {
        $grpexist = Get-ADGroup -Filter {name -eq $group}
        if ($null -eq $grpexist)
        {
            New-ADGroup -Name $group -SAMAccountName $group -GroupCategory Security -GroupScope Global -Path "OU=$ou,$dn"
        }
        
        Add-ADGroupMember -Identity $group -Members $user.account
    }
}

Write-Host "The operation completed successfully." -ForegroundColor Green