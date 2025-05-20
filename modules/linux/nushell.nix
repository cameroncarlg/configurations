{
  programs.nushell = {
    enable = true;
    shellAliases = {
      sw = "sudo nixos-rebuild switch --flake /home/cameron/configurations";
      hxc = "sudo hx /home/cameron/configurations/hosts/nixos-server/home.nix";
      hxcv = "sudo hx /home/cameron/configurations/hosts/nixos-server/configuration.nix";
      lg = "lazygit";
      ll = "ls -la";
      ff = "fastfetch";
     };
  };
}
