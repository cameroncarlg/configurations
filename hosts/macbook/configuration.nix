{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    neofetch
    fastfetch
    helix
    #nushell
  ];

  # Allows Determinate Systems to manage nix
  nix.enable = false;

  # Enables flakes, nix
  nix.settings.experimental-features = "nix-command flakes";

  # Allows fish to be default shell
  programs.fish.enable = true;

  #system.configurationRevision = self.rev or self.dirtyRev or null;
  
  # Keeping your state version
  system.stateVersion = 6;

  # Ensure this matches your hardware
  nixpkgs.hostPlatform = "aarch64-darwin"; 

  # Setting users
  users.users.cameron = {
    shell = pkgs.fish;
    name = "cameron";
    home = "/Users/cameron";
  };
}
