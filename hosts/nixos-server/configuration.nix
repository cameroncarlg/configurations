# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

# { config, pkgs, ... }:
{ pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      #inputs.nix-minecraft.nixosModules.mincraft-servers
    ];

  #nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

  # Garbage Collection
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

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
  networking.extraHosts = ''
    127.0.0.1 mealie.local
    127.0.0.1 dashboard.local
    127.0.0.1 jellyfin.local
    127.0.0.1 jellyseer.local
    127.0.0.1 sonarr.local
    127.0.0.1 prowlarr.local
    127.0.0.1 audiobookshelf.local
    127.0.0.1 paperless.local
    127.0.0.1 home-assistant.local
    127.0.0.1 pinchflat.local
    127.0.0.1 navidrome.local
    127.0.0.1 immich.local
    127.0.0.1 resourcepack.local
    127.0.0.1 open-webui.local
    127.0.0.1 qbit.local
    127.0.0.1 n8n.local
    127.0.0.1 uptime-kuma.local
    127.0.0.1 vikunja.local
    127.0.0.1 syncthing.local
    127.0.0.1 ntfy.local
    192.168.0.18 mealie.local
    192.168.0.18 jellyfin.local
    192.168.0.18 jellyseer.local
    192.168.0.18 dashboard.local
    192.168.0.18 open-webui.local
    192.168.0.18 uptime-kuma.local
  '';
  
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

  # HOMELAB
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

  services.audiobookshelf = {
    enable = true;
    openFirewall = true;
  };

  services.pinchflat = {
    enable = true;
    openFirewall = true;
    selfhosted = true;
  };

  services.vaultwarden = {
    enable = true;
  };

  services.immich = {
    enable = true;
    openFirewall = true;
  };

  environment.etc."paperless-admin-pass".text = "admin";
  services.paperless = {
    enable = true;
    passwordFile = "/etc/paperless-admin-pass";
  };

  ##services.firefly-iii = {
  ##  enable = true;
  ##  settings = {
  ##    APP_KEY_FILE = "/home/cameron/app-key.txt";
  ##  };
  #};

  #services.home-assistant = {
  #  enable = true;
  #  extraComponents = [
  #    # Components required to complete the onboarding
  #    "analytics"
  #    "google_translate"
  #    "met"
  #    "radio_browser"
  #    "shopping_list"
  #    "isal"
  #    "ibeacon"
  #    "govee_ble"
  #    "spotify"
  #    "kegtron"
  #    "snooz"
  #    "dlna_dmr"
  #  ];
  #  config = {
  #    # Includes dependencies for a basic setup
  #    # https://www.home-assistant.io/integrations/default_config/
  #    default_config = {};
  #  };
  #};

  #services.minecraft-servers = {
  #  enable = true;
  #  eula = true;
  #  servers = {
  #    cool-server1 = {
  #      enable = true;
  #    };
  #  };
  #};

  services.minecraft-server = {
    enable = true;
    eula = true;
    openFirewall = true; # Opens the port the server is running on (by default 25565 but in this case 43000)
    declarative = true;
    #whitelist = {
    #  # This is a mapping from Minecraft usernames to UUIDs. You can use https://mcuuid.net/ to get a Minecraft UUID for a username
    #  #username1  = "2e73072d-c5ef-4ae3-9d1b-d28166cda3c2"; #czzzAR
    #  # username2 = "yyyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyyyy";
    #};
    serverProperties = {
      level-name = "test";
      player-idle-timeout = 5;
      allow-flight = false;
      server-port = 43000;
      difficulty = 3;
      gamemode = 0;
      pvp = true;
      max-players = 5;
      motd = "Mother Fucking Minecraft Self Hosted Server";
      # white-list = true;
      allow-cheats = false;
      #resource-pack = "http://resourcepack.local/dramatic_skys.zip";
      #resource-pack-id = "b7bed5d1-d396-47ba-9974-c90784a4e123";
      #resource-pack-sha1 = "7dc1a5857421a201ad27c356946927ec921ed896";
      #resource-pack-prompt = "test!";
    };
    # jvmOpts = "-Xms4092M -Xmx4092M -XX:+UseG1GC -XX:+CMSIncrementalPacing -XX:+CMSClassUnloadingEnabled -Xmx2048M -Xms2048M -Djava.net.preferIPv4Stack=true";
  };

  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
  };

  #services.factorio = {
  #  enable = true;
  #  openFirewall = true;
  #};

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

  services.ollama = {
    enable = true;
    port = 11434;
    #acceleration = "rocm";
    openFirewall = true;
  };

  ###services.nextjs-ollama-llm-ui = {
  ###  enable = true;
  ###};

  ###services.navidrome= {
  ###  enable = true;
  ###  openFirewall = true;
  #};

  services.caddy = {
    enable = true;
    virtualHosts = {
      "http://mealie.local" = {
        extraConfig = ''
          reverse_proxy localhost:9000
        '';
      };
      "http://dashboard.local" = {
        extraConfig = ''
          reverse_proxy localhost:8082
        '';
      };
      "http://jellyfin.local" = {
        extraConfig = ''
          reverse_proxy localhost:8096
        '';
      };
      "http://jellyseer.local" = {
        extraConfig = ''
          reverse_proxy localhost:5055
        '';
      };
      "http://sonarr.local" = {
        extraConfig = ''
          reverse_proxy localhost:8989
        '';
      };
      "http://prowlarr.local" = {
        extraConfig = ''
          reverse_proxy localhost:9696
        '';
      };
      "http://audiobookshelf.local" = {
        extraConfig = ''
          reverse_proxy localhost:8000
        '';
      };
      "http://paperless.local" = {
        extraConfig = ''
          reverse_proxy localhost:28981
        '';
      };
      "http://home-assistant.local" = {
        extraConfig = ''
          reverse_proxy localhost:8123
        '';
      };
      "http://pinchflat.local" = {
        extraConfig = ''
          reverse_proxy localhost:8945
        '';
      };
      "http://immich.local" = {
        extraConfig = ''
          reverse_proxy localhost:2283
        '';
      };
      "http://open-webui.local" = {
        extraConfig = ''
          reverse_proxy localhost:8083
        '';
      };
      "http://qbit.local" = {
        extraConfig = ''
          reverse_proxy localhost:8080
        '';
      };
      "http://n8n.local" = {
        extraConfig = ''
          reverse_proxy localhost:5678
        '';
      };
      "http://uptime-kuma.local" = {
        extraConfig = ''
          reverse_proxy localhost:4000
        '';
      };
      "http://vikunja.local" = {
        extraConfig = ''
          reverse_proxy localhost:3456
        '';
      };
      "http://syncthing.local" = {
        extraConfig = ''
          reverse_proxy localhost:8384
        '';
      };
      #"resourcepack.local:80" = {
      #  extraConfig = ''
      #    root * /var/www/minecraft-resource-packs
      #    file_server
      # '';
      #};
    };
  };

  services.homepage-dashboard = {
    enable = true;
    openFirewall = true;
    allowedHosts = "dashboard.local";
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
      #{
      #  openweathermap = {
      #    label = "Seattle";
      #    target = "_blank";
      #    latitude = "47.6";
      #    longitude = "-122.33";
      #    units = "metric";

      #  };
      #}
      #{
      #  widget = {
      #    type = "podcasts";
      #    url = "http://localhost:8000";
      #    key = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiJmZDY2MTEyZi05YWZhLTQ5MGYtODczMC1lODU0YTMxNTRlNjUiLCJ1c2VybmFtZSI6InJvb3QiLCJpYXQiOjE3NTEyNTUxMjJ9.pDUDkMuxRdpjPV9H4HM0cBLfpJyp1p1Z7yM6d8MpuVg";
      #  };
      #}
  ];
    services = [
      {
        "Media" = [
          {
            "Jellyfinn" = {
              description = "Free Software Media System - Server Backend & API";
              href = "http://jellyfin.local";
            };
          }
          {
            "Jellyseer" = {
              description = "Open-source media request and discovery manager for Jellyfin";
              href = "http://jellyseer.local";
            };
          }
          {
            "Sonarr" = {
              description = "Smart PVR (Personal Video Recorder) for bit users";
              href = "http://sonarr.local";
            };
          }
          {
            "Prowlarr" = {
              description = "Index Manager/Proxy built to integrate with PVR apps";
              href = "http://prowlarr.local";
            };
          }
          {
            "Pinchflat" = {
              description = "Your next YouTube media manager";
              href = "http://pinchflat.local";
            };
          }
          {
            "AudioBookShelf" = {
              description = "Self-hosted audiobook and podcast server";
              href = "http://audiobookshelf.local";
            };
          }
          {
            "Immich" = {
              description = "High performance self-hosted photo and video management solution";
              href = "http://immich.local";
            };
          }
          {
            "Vikunja" = {
              description = "The to-do app to organize your life.";
              href = "http://vikunja.local";
            };
          }
        ];
      }
      {
        "Automation" = [
          #{
          #  "Home Assistant" = {
          #    description = "Open source home automation that puts local control and privacy first";
          #    href = "https://home-assistant.local";
          #  };
          #}
          {
            "Uptime-kuma" = {
              description = "A fancy self-hosted monitoring tool";
              href = "http://uptime-kuma.local";
            };
          }
          {
            "Mealie" = {
              description = "Self hosted recipe manager and meal planner";
              href = "http://mealie.local";
            };
          }
          {
            "Paperless-ngx" = {
              description = "Community-supported supercharged document management system: scan, index and archive all your documents";
              href = "http://localhost:28981";
            };
          }
          {
            "Vaultwarden" = {
              description = "Unofficial Bitwarden compatible server written in Rust";
              href = "http://localhost:8222";
            };
          }
          {
            "Syncthing" = {
              description = "Open Source Continuous File Synchronization";
              href = "http://syncthing.local";
            };
          }
          {
            "Open-webui" = {
              description = "Chat UI for Self Hosted LLMs";
              href = "http://open-webui.local";
            };
          }
          {
            "n8n" = {
              description = "Automation GUI for Self Hosted LLMs";
              href = "http://n8n.local";
            };
          }
          {
            "ntfy" = {
              description = "Automated multi-push notification system";
              href = "http://ntfy.local";
            };
          }
          #{
          #  "Github" = {
          #    description = "Link to personal github repo";
          #    href = "https://github.com/cameroncarlg";
          #  };
          #}
        ];
      }
    ];
  };

  services.open-webui = {
    enable = true;
    openFirewall = true;
    port = 8083;
  };

  services.n8n = {
    enable = true;
    openFirewall = true;
  };

  services.uptime-kuma = {
    enable = true;
    settings = {
      PORT = "4000";
    };
  };

  services.vikunja = {
    enable = true;
    frontendScheme = "https";
    frontendHostname = "vikunja";
  };

  services.ntfy-sh = {
    enable = true;
    settings = {
      listen-http = ":8081";
      base-url = "https://ntfy.example";
    };
  };

  ##service.actual = {
  ##  enable = true;
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
    vim
    wget
    git
    neovim
    brave
    gnome-tweaks
    mullvad
    mullvad-vpn
    nginx
    qbittorrent-enhanced
    python3
    aichat
    remmina
    gitlab
    nushell
    claude-code
    ollama
    privoxy
    #minecraft
    minecraft-server
    #factorio

    # Homelab 
    mealie
    jellyfin
    jellyseerr
    sonarr
    prowlarr
    paperless-ngx
    #home-assistant
    homepage-dashboard
    vaultwarden
    caddy
    immich
    open-webui
    n8n
    uptime-kuma
    vikunja
    syncthing
    ntfy-sh
    baobab
    #meshcentral
    #actual-server
    #firefly-iii
    #navidrome
    #fosrl-pangolin
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
  networking.firewall.allowedTCPPorts = [ 9000 80 443 8191 8096 53 28981 43000 8083 8945 3001 4000 3456 8384 8081 ];
  networking.firewall.allowedUDPPorts = [ 9000 80 443 8191 8096 53 28981 43000 8083 8945 3001 4000 3456 8384 8081 ];
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
