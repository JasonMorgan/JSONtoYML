function parseYml {
  param (
    [string]$string
  )
  $string = $string.Split('`n')
  $line_count = $string.count
  if (! ($string[0] -match '---')) {
    throw 'invalid text, yaml docs must start with "---"'
  }
  $obj_count = 0
  $greedy = $false
  foreach ($s in $string) {
    if ($greedy) {
      # Append to the last until next property comes in then $greedy needs to be false
      # continue so the switch doesn't get hit
    }
    switch -Regex ($s) {
      '^---.*$' {
        $obj_count ++
        $doc_start = $true
        $docs_tags = $s | getTags
      }
      '^#.*$' {continue}
      '^?.*$' {
        "I belong to a complex key value pairing"
      }
      '|' {
        'Literal String, preserve line breaks'
        'Could follow ---'
      }
      '>' {
        'Literal String, do not preserve line breaks'
        # Has exceptions, new lines are preserved for blank lines and more indented lines
        'Could follow ---'
      }
      '^\.\.\.$' {
        $doc_start = $false
        $doc_end = $true
      }
    }
    $obj = ''
    $obj
  }
}

parseYml (Get-Content -Raw E:\cookbooks\admin_workstation\.kitchen.yml)