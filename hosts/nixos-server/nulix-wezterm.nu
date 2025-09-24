#!/usr/bin/env nu
def "main lazygit" [] {
  wezterm cli split-pane --bottom --percent 50 lazygit
}

def "main lazysql" [] {
  wezterm cli spawn lazysql
}

def "main yazi" [] {
  wezterm cli split-pane --left --percent 50 yazi
}

def main [] {
  print "hello"
}
