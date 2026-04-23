{ inputs, ... }:
{
  imports = [
    ./nushell.nix
    ./starship.nix
    ./fish.nix
    ./tmux.nix
    ./wezterm.nix
    #./minecraft.nix
  ];
}
