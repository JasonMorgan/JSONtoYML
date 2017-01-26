enum ymlLineType {
  header
  array # so far looking at both lines that start with - and the ruby array syntax [] with commas
  mapping # essentially a hash
  complex_mapping # line that starts with a ?
}

enum ymlValueType {
  string
  int
  float
  string_literal_hard # start with |
  string_literal_soft # start with >
  node # Special yml reprenstation of an item that occurs multiple times in a doc
  datetime
}

class ymlDoc { # not sure I'll need or want this.

}

class simpleToken {
  #Properties

  [int]$line_number
  [string]$content
  [int]$indentation
  [bool]$is_greedy

  #Contructors

  simpleToken () {}

  simpleToken ([string]$string,[int]$line_number) {
    $null = $string -match '^(?<whitespace> *)(?<everythingElse>.*)$'
    switch ($Matches.whitespace.Length) {
      0 {$indent = 0; continue}
      default {[int]$indent = ($Matches.whitespace.Length / 2)}
    }
    $greedy = $false
    if ($string -match '.*\|.*|.*\>.*') {
      $greedy =$true
    }

    $this.line_number = $line_number
    $this.content = $string
    $this.indentation = $indent
    $this.is_greedy = $greedy
  }
  #Methods

  static [simpleToken[]] getMySimpleTokens ([string]$doc) {
    $count = 0
    $tokens = @()
    foreach ($l in $doc.Split("`n")) {
      $tokens += [simpleToken]::new($l, $count)
      $count ++
    }
    return $tokens
  }

  static [hashtable] whosMyDaddy ([simpleToken[]]$simple_tokens) {
    $return = @{}
    foreach ($s in $simple_tokens) {
      if ($s.indentation -ge 1) {
        [int]$value = $simple_tokens.where{ $_.line_number -lt $s.line_number -and $_.indentation -eq ($s.indentation - 1) }[-1].line_number
        $return.Add($s.line_number,$value)
      }
    }
    return $return
  }
}

class ymlToken {
  #Properties
  [int]$line_number
  [int]$parent_line
  [string]$content
  [int]$indentation
  [ymlLineType]$line_type # adding an enum class
  [int]$document # probably want to switch data types

  #Contructors
  ymlToken () {}

  ymlToken ([simpleToken[]]$simple_tokens) { # Am I really a constructor?  SHouldn't I be a method?

  # determine parents

  $parents = [simpleToken]::whosMyDaddy($simple_tokens)

    foreach ($s in $simple_tokens) {
      # map simpleToken values
      $this.line_number = $s.line_number
      $this.content = $s.content
      $this.indentation = $s.indentation

      # set the parent line
      if ($s.indentation -ge 1) {
        $this.parent_line = $parents.$s.line_number
      } else {
        $this.parent_line = 0
      }

      # determine line type

      switch -Regex ($s.content.TrimStart(' ')) {
        '^---.*$' {
          $this.line_type = 'header'
          continue
        }
        '^-.*$' {
          $this.line_type = 'array'
          continue
        }
        '^.*:.*$' {
          $this.line_type = 'mapping'
          continue
        }
        '?' {
          $this.line_type = 'complex_mapping'
          continue
        }
        default {throw "Shoot, I don't understand how to handle this: $($s.content)"}
      }

      # determine document

      $this.document = 0 # Hopefully this fails hard on my document detection test

    }

  }

  #Methods

  static [ymlToken[]] helpMeTokenizeIt ([string]$doc) {
    $simple_tokens = [simpleToken]::getMySimpleTokens($doc)
    $tokens = [ymlToken]::new($simple_tokens)
    return $tokens
  }
  <#[ymlToken[]] HelpMeTokenizeIt ([string]$doc) {
    $doc.Split('`n')
    $obj_count = 0
    $line_count = 0
    $greedy = $false
    foreach ($line in $doc) {
      $token = [ymlToken]::new()
      $token.line_number = $line_count
      $line_count ++
      switch -Regex ($line) {
      '^---.*$' {
        $obj_count ++
        $doc_start = $true
        $docs_tags = $line | getTags
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
    }#>
}

# Uncomment to run the code
# $content = get-content -Raw ../../test/fixtures/yaml_docs/kitchen_file.yml
# $tokenizer = [ymlToken]::new()
# $tokenizer.HelpMeTokenizeIt($content)
