#!/bin/sh

awk '
  /^[[:space:]]*Host[[:space:]]/ { exit }
  /^[[:space:]]*$/ { empty_lines++; next }
  {
    while (empty_lines > 0) {
      print ""
      empty_lines--
    }
    print
  }
'
