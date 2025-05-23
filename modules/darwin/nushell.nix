{
  programs.nushell = {
    enable = true;
    #packages = inputs.nushell.packages.${pkgs.system}.default;
    shellAliases = {
      sw = "sudo darwin-rebuild switch --flake /Users/cameron/configurations";
      hxc = "sudo hx /Users/cameron/configurations/hosts/macbook/home.nix";
      hxcv = "sudo hx /Users/cameron/configurations/hosts/macbook/configuration.nix";
      lg = "lazygit";
      ll = "ls -la";
    };
  };
}
