
function ConvertFrom-Yml {
  [CmdletBinding()]
  param (
    # Parameter help description
    [Parameter(Mandatory,
    ValueFromPipeline,
    ValueFromPipelineByPropertyName,
    ParameterSetName='Default')]
    [string]$InputObject,
    [Parameter(ParameterSetName='File')]
    [string]$DestinationPath,
    [Parameter(Mandatory,
    ValueFromPipeline,
    ValueFromPipelineByPropertyName,
    ParameterSetName='File')]
    [string]$Path
  )
  begin {}
  process {}
  end {}
}