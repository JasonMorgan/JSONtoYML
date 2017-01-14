$ModuleManifestName = 'JSONtoYML.psd1'
$ModuleManifestPath = "$PSScriptRoot\..\$ModuleManifestName"
Import-Module $ModuleManifestPath

Describe 'Module Manifest Tests' {
    It 'Passes Test-ModuleManifest' {
        Test-ModuleManifest -Path $ModuleManifestPath
        $? | Should Be $true
    }
}

Describe 'Adds global override of Depth Parameter' {
    It 'Ensure the default parameter for convertto-json exists' {
        $PSDefaultParameterValues.'Convertto-Json:Depth' -eq 100 | Should Be $true
    }
}

Describe 'Understands when the input arrives via Get-Content' {
    It 'Detects input from Get-Content' {
        throw $false
    }
}

Describe 'Converts a string from JSON' {
    It 'Reads a file into a single string' {
        throw $false
    }
    It 'Converts a valid string into a PSObject' {
        throw $false
    }
}

Describe 'Converts a string from YAML' {
    It 'Reads a file into a single string' {
        throw $false
    }
    It 'Converts a valid string into a PSObject' {
        throw $false
    }
}

Describe 'Converts an Object into a YAML string' {
    It 'Generates a single string' {
        throw $false
    }
    It 'Produces a string that is valid YAML' {
        throw $false
    }
}

Describe 'Converts individual files' {
    It 'Reads a YAML file and outputs JSON' {
        throw $false
    }
    It 'Reads a JSON file and outputs YAML' {
        throw $false
    }
}

