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

Describe 'Tokenizer behavior' {
    Context 'Reads a yaml file and converts each line into a simpleToken object' {
        It 'Creates one object per line' {
            $string = Get-Content -Raw ./test/fixtures/yaml_docs/3_line_yaml.yml
            ([simpleToken]::getMySimpleTokens($string) | Measure-Object).count | Should Be 3
        }
        It 'Makes each object a simpleToken' {
            $false | should be $true
        }
    }
}

Describe 'Converts a string from YAML' {
    It 'flattens a string array' {
        ('a','b','c' | ConvertFrom-Yml | Measure-Object).count -eq 1 | Should Be $true
    }
    It 'Converts a valid string into a PSObject' {
        $false | should be $true
    }
    It 'Converts a valid file into a PSObject' {
        $false | should be $true
    }
}

Describe 'Converts an Object into a YAML string' {
    It 'Generates a single string' {
        $false | should be $true
    }
    It 'Produces a string that is valid YAML' {
        $false | should be $true
    }
    It 'Creates a valid YAML file' {
        $false | should be $true
    }
}

Describe 'Converts individual files' {
    It 'Reads a YAML file and outputs JSON' {
        $false | should be $true
    }
    It 'Reads a JSON file and outputs YAML' {
        $false | should be $true
    }
}

