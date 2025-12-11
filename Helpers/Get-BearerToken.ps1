function Get-CONNECTBearerToken 
{
    $DiscoveryUrlRequest = Invoke-WebRequest -Uri ($API_RESOURCE + "/identity/.well-known/openid-configuration") -Method Get -UseBasicParsing
    $DiscoveryBody = $DiscoveryUrlRequest.Content | ConvertFrom-Json
    $TokenUrl = $DiscoveryBody.token_endpoint

    # Step 3: use the client ID and Secret to get the needed bearer token
    $TokenForm = @{
        client_id = $CLIENT_ID
        client_secret = $CLIENT_SECRET
        grant_type = "client_credentials"
    }

    $TokenRequest = Invoke-WebRequest -Uri $TokenUrl -Body $TokenForm -Method Post -ContentType "application/x-www-form-urlencoded" -UseBasicParsing
    $TokenBody = $TokenRequest | ConvertFrom-Json
    $Global:CONNECT_BEARERTOKEN = $TokenBody.access_token
}