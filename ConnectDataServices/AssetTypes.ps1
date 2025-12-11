$ASSET_TYPES_STRING = "AssetTypes"

class TypeReference {
    [string]$StreamReferenceId
    [string]$StreamReferenceName
    [string]$Description
    [string]$TypeId
}

class Metadata {
    [string]$Id
    [string]$Name
    [string]$Description
    [string]$SdsTypeCode
    [System.Object]$Value
    [string]$Uom
}

class AssetType {
    [string]$Id
    [string]$Name
    [string]$Description
    [TypeReference[]]$TypeReferences
    [Metadata[]]$Metadata
}

function Get-AssetType {
    param (
        [string]$AssetTypeId = $null
    )
    $uri = "$(Build-NamespaceBaseRoute)/$($ASSET_TYPES_STRING)/$($AssetTypeId)"
    return Invoke-RestMethod -Method Get -Uri $uri -Headers (Get-DefaultRequestHeaders)
}

function Add-AssetType {
    param (
        [string]$AssetTypeId = $null,
        [string]$AssetType = $null
    )
    $uri = "$(Build-NamespaceBaseRoute)/$($ASSET_TYPES_STRING)/$($AssetTypeId)"
    return Invoke-RestMethod -Method Post -Uri $uri -Headers (Get-DefaultRequestHeaders) -Body $AssetType
}