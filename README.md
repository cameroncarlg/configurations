# Nix Configuration

A unified Nix configuration managing macOS and Linux environments through a single flake, providing consistent development environments with platform-specific customizations.

## Features

- **Cross-Platform**: macOS (Apple Silicon) via nix-darwin, Linux via NixOS
- **System**: Fish shell, GNOME (Linux), VPN support
- **Home**: Consistent user environment with home-manager
- **Server**: Media stack (Jellyfin, Sonarr), Mealie, Mullvad VPN

## Usage

```bash
# macOS
nix build .#darwinConfigurations.Camerons-MacBook-Pro.system
./result/sw/bin/darwin-rebuild switch --flake .

# Linux
nixos-rebuild switch --flake .#nixos
```

## Structure

- `flake.nix`: Configuration entry point
- `hosts/`: Platform configs (macbook, nixos-server)
- `modules/`: Shared modules
