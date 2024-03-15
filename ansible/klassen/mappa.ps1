# Inloggningsuppgifter till resursen
$UserName = "larskaggdata.local\elever"
$Password = "Minne2022"
$senPass = ConvertTo-SecureString $Password -AsPlainText -Force
[pscredential]$cred = New-Object System.Management.Automation.PSCredential($UserName, $senPass)

# Sökvägen till resursen
$remotepath = "\\larskaggdata.local\kagg_filer"

# Mappa resursen
New-PSDrive -Persist -Name "M" -PSProvider "FileSystem" -Root $remotepath -Credential $cred  -Scope Global
