$ASSETS_STRING = "Assets"

function Get-Assets {
    param (
        [int]$Skip = 0,
        [int]$Count = 100,
        [string]$Query = $null
    )
    $uriEscapedQuery = [uri]::EscapeDataString($Query)
    $uri = "$(Build-NamespaceBaseRoute)/$($ASSETS_STRING)?skip=$Skip&count=$count&query=$uriEscapedQuery"
    return Invoke-RestMethod -Method Get -Uri $uri -Headers (Get-DefaultRequestHeaders)
}

function Get-Asset {
    param (
        [Parameter(Mandatory=$true)]
        [string]$AssetId
    )

    if ([string]::IsNullOrWhiteSpace($AssetId))
    {
        throw "Please specify a non-null or empty asset id."
    }

    $uri = "$(Build-NamespaceBaseRoute)/$ASSETS_STRING/$AssetId"
    return Invoke-RestMethod -Method Get -Uri $uri -Headers (Get-DefaultRequestHeaders)
}