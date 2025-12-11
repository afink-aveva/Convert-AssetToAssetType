# Declare globals to be populated from appsetting
$Global:API_RESOURCE = ""
$Global:API_VERSION = "v1"
$Global:TENANT_ID = ""
$Global:NAMESPACE_ID = ""
$Global:CLIENT_ID = ""
$Global:CLIENT_SECRET = ""
$Global:CONNECT_BEARERTOKEN = ""

# Dot reference all helper files
Get-ChildItem -Path "$PSScriptRoot\Helpers\" -Filter *.ps1 -Recurse | ForEach-Object{. $_.FullName }

# Dot reference all CONNECT data services api files
Get-ChildItem -Path "$PSScriptRoot\ConnectDataServices\" -Filter *.ps1 -Recurse | ForEach-Object{. $_.FullName }

# ADH1
#     "ClientId": "1a66d4c0-1be7-4960-81d5-25192aeab88b",
#    "ClientSecret": "+VsA9JcRXRD0vDFBasgSa4vhCbQTUeTC++TeUAg/ct4="


$appSettings = Get-AppSettings
$Global:API_RESOURCE = $appSettings.Resource
$Global:API_VERSION = $appSettings.ApiVersion
$Global:TENANT_ID = $appSettings.TenantId
$Global:NAMESPACE_ID = $appSettings.NamespaceId
$Global:CLIENT_ID = $appSettings.ClientId
$Global:CLIENT_SECRET = $appSettings.ClientSecret
$Global:ASSET_ID = $appSettings.AssetId
Get-CONNECTBearerToken

$ErrorActionPreference = 'Stop'
$AssetId = $Global:ASSET_ID

# Step 1 - Get the asset of interest
Write-Host "Starting Convert-AssetToAssetType..."
Write-Host "Getting asset with Id: $($AssetId)"

$asset = Get-Asset -AssetId $AssetId
$newAssetId = New-Guid
$assetTypeToCreate = [AssetType]::new()
$assetTypeToCreate.Id = $newAssetId
$assetTypeToCreate.Name = $asset.Name
$assetTypeToCreate.Description = $asset.Description

Write-Host "Getting stream reference information..."
[System.Collections.ArrayList]$typeReferences = @()
foreach ($streamReference in $asset.StreamReferences) {
    $typeReference = [TypeReference]::new()
    $stream = Get-Stream -Id $streamReference.StreamId
    if ($null -eq $stream) { continue }
    $typeReference.StreamReferenceId = $streamReference.Id
    $typeReference.StreamReferenceName = $streamReference.Name
    $typeReference.Description = $streamReference.Description
    $typeReference.TypeId = $stream.TypeId
    $null = $typeReferences.Add($typeReference)
}

#[System.Collections.ArrayList]$metadatas = @()
# foreach ($metadata in $asset.Metadata) {
#     $metadataToAdd = [Metadata]::new()
#     $metadataToAdd.Id = $metadata.Id
#     $metadataToAdd.Name = $metadata.Name
#     $metadataToAdd.Description = $metadata.Description
#     $metadataToAdd.SdsTypeCode = $metadata.SdsTypeCode
#     $metadataToAdd.Value = $metadata.Value
#     $metadataToAdd.Uom = $metadata.Uom

#     $null = $metadatas.Add($metadataToAdd)
# }

#$assetTypeToCreate.Metadata = $metadatas
$assetTypeToCreate.TypeReferences = $typeReferences
Add-AssetType -AssetTypeId $assetTypeToCreate.Id -AssetType (ConvertTo-Json -InputObject $assetTypeToCreate)

