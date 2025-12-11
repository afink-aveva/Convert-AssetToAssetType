# Convert-AssetToAssetType
Script to help convert an existing CONNECT data services asset into an asset type

## Usage
1. Copy the repository to your local machine
2. In the CONNECT data services portal, create a [Client-Credential Client](https://datahub.connect.aveva.com/clients) and note the `ClientId` and `ClientSecret`
3. Copy the `appsettings.placeholder.json` and rename to `appsettings.json`
4. Fill in the placeholder configuration items, like `TenantId`, `NamespaceId`, `ClientId`, `ClientSecret`, `AssetId`
5. Run the script in PowerShell `Convert-AssetToAssetType.ps1`

_Note that you may need to set the ExecutionPolicy on your machine to allow the script to run_

## Limitations
- only supports copying stream references, not metadata or status configuration
