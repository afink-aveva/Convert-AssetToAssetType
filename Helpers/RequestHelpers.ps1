function Build-NamespaceBaseRoute
{
    return "$API_RESOURCE/api/$API_VERSION/tenants/$TENANT_ID/namespaces/$NAMESPACE_ID"
}

function Get-DefaultRequestHeaders
{
    $headers = @{
        "Authorization" = "Bearer $CONNECT_BEARERTOKEN"
        "Content-Type" = "application/json"
    }

    return $headers
}