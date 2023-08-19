
$secrets = Get-AzKeyVaultSecret -VaultName $keyvault -Name "secret-object" -AsPlainText
 $secrets | ConvertFrom-Json

 -password $secrets.password 