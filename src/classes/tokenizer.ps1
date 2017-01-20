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

class ymlToken {
  #Properties
  [int]$line_number
  [int]$parent_line
  [string]$content
  [int]$indentation
  [string]$line_type # adding an enum class
  [string]$data_type # adding an enum class
  [string]$document # probably want to switch data types
}