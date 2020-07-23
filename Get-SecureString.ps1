$credenciales = Get-Credential
$Encrypted = ConvertFrom-SecureString -SecureString ($credenciales.GetNetworkCredential().securepassword) ;  $Encrypted | Out-File -Encoding ascii -FilePath encrypted.txt
