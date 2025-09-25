{ inputs, ... }:
{
  imports = [
    ./nushell.nix
    ./starship.nix
    ./fish.nix
    ./wezterm.nix
  ];
}
