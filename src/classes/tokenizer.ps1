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

  #Contructors

  simpleToken () {}

  simpleToken ([string]$string,[int]$line_number) {
    $null = $string -match '^(?<whitespace> *)(?<everythingElse>.*)$'
    switch ($Matches.whitespace.Length) {
      0 {$indent = 0; continue}
      default {[int]$indent = ($Matches.whitespace.Length / 2)}
    }
    $this.line_number = $line_number
    $this.content = $string
    $this.indentation = $indent
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
}

class ymlToken {
  #Properties
  [int]$line_number
  [int]$parent_line
  [string]$content
  [int]$indentation
  [string]$line_type # adding an enum class
  [string]$data_type # adding an enum class
  [string]$document # probably want to switch data types

  #Contructors
  ymlToken () {}

  ymlToken ($token) {
    #$this.line_number = $token.line_number
    #$this.parent_line = $token.parent_line
    #$this.content = $token.content
    #$this.indentation = $token.indentation
  }

  #Methods
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
