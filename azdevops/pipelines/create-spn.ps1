param (
    $consumerSpName
)

$ErrorActionPreference = "Stop"

function ConvectsecureStringToPlainText {
    param (
        [SecureString] $securestring
    )

    # Convert SecureString to plain text
    return ConvertFrom-SecureString $securestring -AsPlainText
}
function Callapi {
    param (
        $uri,
        [SecureString] $token,
        $method = "GET",
        $body = $null
    )

    # Convert SecureString token to plain text
    $plainToken = ConvectsecureStringToPlainText $token
    $headers = @{
        "Authorization" = "Bearer $plainToken"
        "Content-Type" = "application/json"
    }

    Write-Host "Calling $method $uri"

    try {
        $response = Invoke-WebRequest -Uri $uri -Method $method -Headers $headers -Body $body
        Write-Host "Response Status Code: $($response.StatusCode)"
        return $response.Content | ConvertFrom-Json
    }
    catch {
        Write-Error "Error during API call: $($_.Exception.Message)"
        if ($_.Exception.Response) {
            $streamReader = [System.IO.StreamReader]::new($_.Exception.Response.GetResponseStream())
            $errResp = $streamReader.ReadToEnd() | ConvertFrom-Json
            $streamReader.Close()
            Write-Error "Detailed Error: $($errResp | Format-List | Out-String)"
        }
    }
}

function CreateAppRegistration {
    param (
        $displayName,
        [SecureString] $token
    )

    Write-Host "Creating app registration $displayName"

    $uri = "https://it4it.abnamro.com/tiecafunctions/managedsp/New-Serviceerincipal"

    $body = @{
        "DisplayName" = $displayName
    } | ConvertTo-Json -Compress

    Callapi $uri $token "POST" $body

    $managedspnToken = $((Get-AzAccessToken -ResourceUrl "https://managedsp-sp.abnamro.com" -AsSecureString).Token)

    CreateAppRegistration $consumerSpName $managedspnToken
}