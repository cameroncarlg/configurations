# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

# { config, pkgs, ... }:
{ pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Garbage Collection
  nix.settings.auto-optimise-store = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # /etc/hosts
  networking.extraHosts = "192.168.0.18 local";
  
  #networking.extraHosts = 
  #''
  #  192jellyfin18 nixos.local
  #http://192.168.0.18;
  
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation pro#perties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Homelab Services
  #services.mealie-nightly-enable = true;
  services.mealie = {
    enable = true;
    settings = {
      ALLOW_SIGNUP = "true";
    };
  };
  services.mullvad-vpn.enable = true;

  services.jellyfin = {
    enable = true;
    user = "cameron";
    openFirewall = true;
  };

  services.jellyseerr = {
    enable = true;
    openFirewall = true;
  };

  services.sonarr = {
    enable = true;
    openFirewall = true;
  };

  services.prowlarr = {
    enable = true;
    openFirewall = true;
  };

  services.privoxy = {
    enable = true;
  };

  services.flaresolverr = {
    enable = true;
    openFirewall = true;
  };

  services.homepage-dashboard = {
    enable = true;
    openFirewall = true;
    allowedHosts = "192.168.0.18:8082";
    widgets = [
      {
        resources = {
          cpu = true;
          disk = "/";
          memory = true;
        };
      }
      {
        search = {
          provider = "duckduckgo";
          target = "_blank";
        };
      }
  ];
    services = [
      {
        "Media" = [
          {
            "Jellyfinn" = {
              description = "Media Player";
              href = "http://localhost:8096";
            };
          }
          {
            "Jellyseer" = {
              description = "Media Request and Discovery Manager";
              href = "http://localhost:5055";
            };
          }
          {
            "Sonarr" = {
              description = "Smart PVR (Personal Video Recorder) for biT users";
              href = "http://localhost:8989";
            };
          }
          {
            "Prowlarr" = {
              description = "Index Manager/Proxy built to integrate with PVR apps";
              href = "http://localhost:9696";
            };
          }
        ];
      }
      {
        "Lifestyle" = [
          {
            "Mealie" = {
              description = "Recipe Manager and Meal Planner";
              href = "http://localhost:9000";
            };
          }
        ];
      }
    ];
  };

  services.audiobookshelf = {
    enable = true;
    openFirewall = true;
  };

  services.pinchflat = {
    enable = true;
    openFirewall = true;
    selfhosted = true;
  };

  #services.dnsmasq = {
  #  enable = true;
  #  settings = {
  #    domain-needed = true;
  #    bogus-priv = true;
  #    "listen-address" = [ "127.0.0.1" "192.168.0.18"];
  #    address = [
  #      "/jellyfin/192.168.0.18"
  #      "/mealie/192.168.0.18"
  #    ];
  #    server = [
  #      "1.1.1.1"
  #      "8.8.8.8"
  #    ];
  #  };
  #};

  #services.jmusicbot = {
  #  enable = true;
  #};

  #services.gitlab = {
  #  enable = true;
  #  databasePasswordFile = pkgs.writeText "dbPassword" "zgvcyfwsxzcwr85l";
  #  initialRootPasswordFile = pkgs.writeText "rootPassword" "Jdnedejdnede6363!";
  #  secrets = {
  #    secretFile = pkgs.writeText "secret" "Aig5zaic";
  #    otpFile = pkgs.writeText "otpsecret" "Riew9mue";
  #    dbFile = pkgs.writeText "dbsecret" "we2quaeZ";
  #    jwsFile = pkgs.runCommand "oidcKeyBase" {} "${pkgs.openssl}/bin/openssl genrsa 2048 > $out";
  #  };
  #};

  #services.nginx = {
  #  enable = true;
  #  recommendedProxySettings = true;
  #  virtualHosts = {
  #    localhost = {
  #      locations."/".proxyPass = "http://unix:/run/gitlab/gitlab-workhorse.socket";
  #    };
  #  };
  #};

  #systemd.services.gitlab-backup.environment.BACKUP = "dump";

  #services.ollama = {
  #  enable = true;
  #  port = 11434;
  #  acceleration = "rocm";
  #  openFirewall = true;
  #};

  #services.nextjs-ollama-llm-ui = {
  #  enable = true;
  #};

  #services.caddy = {
  #  enable = true;
  #  virtualHosts = {
  #    "mealie" = {
  #      extraConfig = ''
  #        reverse_proxy localhost:9000
  #      '';
  #    };
  #  };
  #};

  #services.emacs = {
  #  enable = true;
  #};

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.cameron = {
    shell = pkgs.nushell;
    isNormalUser = true;
    description = "cameron";
    extraGroups = [ "networkmanager" "wheel" ];
    #packages = with pkgs; [
    #  thunderbird
    #];
  };

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "cameron";

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Install firefox.
  programs.firefox.enable = true;

  # Install fish.
  programs.fish.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable flakes and the accompanying cli tools
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
    git
    neovim
    brave
    gnome-tweaks
    jellyfin
    jellyseerr
    sonarr
    prowlarr
    mullvad
    mullvad-vpn
    qbittorrent-enhanced
    mealie
    python3
    gitlab
    nginx
    ollama
    aichat
    remmina
    #caddy
    privoxy
    #emacs
    nushell
    claude-code
    #nodejs_22
    homepage-dashboard
    #logseq
    #nextcloud31
    #nextcloud-client
    #rocmPackages.rocm
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 9000 80 443 8191 8096 53 8000 ];
  networking.firewall.allowedUDPPorts = [ 9000 80 443 8191 8096 53 8000 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
