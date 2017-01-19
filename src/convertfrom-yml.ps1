
function ConvertFrom-Yml {
  [CmdletBinding(DefaultParameterSetName='Default')]
  param (
    # Parameter help description
    [Parameter(Mandatory,
    ValueFromPipeline,
    ValueFromPipelineByPropertyName,
    ParameterSetName='Default')]
    [string[]]$InputObject,
    [Parameter(ParameterSetName='File')]
    [string]$DestinationPath,
    [Parameter(Mandatory,
    ParameterSetName='File')]
    [string]$Path
  )
  begin {}
  process {
    $string += $InputObject
  }
  end {
    $string = $string | Out-String
    $string
  }
}