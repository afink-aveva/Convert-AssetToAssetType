$STREAMS_STRING = "Streams"

function Get-Stream {
    param (
        [string]$Id = $null
    )
    $uri = "$(Build-NamespaceBaseRoute)/$($STREAMS_STRING)/$($Id)"
    return Invoke-RestMethod -Method Get -Uri $uri -Headers (Get-DefaultRequestHeaders) -ErrorAction SilentlyContinue
}
