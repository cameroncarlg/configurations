{ lib, ... }:

{
  programs.starship = {
    enable = true;
    enableNushellIntegration = true;
    settings = {
      add_newline = true;
      format = lib.concatStrings [
        "💾 $directory$git_branch> "
        "$line_break"
      ];
    };
  };
}
