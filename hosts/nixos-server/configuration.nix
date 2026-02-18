# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ lib, config, pkgs, ... }:
# { pkgs, ... }:

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

  networking = {
    nameservers = [ "127.0.0.1" "::1" ];
    hostName = "nixos";
    # If using dhcpcd:
    dhcpcd.extraConfig = "nohook resolv.conf";
    # If using NetworkManager:
    networkmanager.dns = "none";

    # enable NAT
    #nat.enable = true;
    #nat.externalInterface = "eth0";
    #nat.internalInterfaces = [ "wg0" ];

    #wireguard.interfaces = {
    #  wg0 = {
    #    ips = [ "10.67.192.78/32" ];
    #    listenPort = 51820;
    #    privateKey = "yP2twFtvJ0uhrZ2jL/3mCKPkE2nTrT6ZAVSYxhKHIEY=";
    #    
    #    # This allows the wireguard server to route your traffic to the internet and hence be like a VPN
    #    # For this to work you have to set the dnsserver IP of your router (or dnsserver of choice) in your clients
    #    postSetup = ''
    #      ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.100.0.0/24 -o eth0 -j MASQUERADE
    #    '';

    #    # This undoes the above command
    #    postShutdown = ''
    #      ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.100.0.0/24 -o eth0 -j MASQUERADE
    #    '';

    #    peers = [
    #      {
    #        publicKey = "qcA8EEYD70XMSDyzxoi6XdTaGK4CP937zG8o9hO+BXQ=";
    #        allowedIPs = [ "10.100.0.2/32" ];
    #        #endpoint = "192.168.0.15:51820";
    #        persistentKeepalive = 25;
    #      }
    #    ];
    #  };
    #};
  };

  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # /etc/hosts
  networking.extraHosts = ''
    127.0.0.1 localhost
  '';
  
  # First certificate: Caddy internal for services
  # Second certificate: For client mtls trust
  security.pki.certificates = [
    ''
      -----BEGIN CERTIFICATE-----
      MIIByDCCAW2gAwIBAgIQbUzX8IhPLgLTWHeDb9Xg2DAKBggqhkjOPQQDAjAwMS4w
      LAYDVQQDEyVDYWRkeSBMb2NhbCBBdXRob3JpdHkgLSAyMDI1IEVDQyBSb290MB4X
      DTI1MDcyNTA2MTg1OFoXDTI1MDgwMTA2MTg1OFowMzExMC8GA1UEAxMoQ2FkZHkg
      TG9jYWwgQXV0aG9yaXR5IC0gRUNDIEludGVybWVkaWF0ZTBZMBMGByqGSM49AgEG
      CCqGSM49AwEHA0IABJi5HeJBItmuqV90VCUVQb7cbCbzJ4MQ7GzHTV0SXmJhzx4t
      hcpml+YNu07WYM/kWAz4tj+jXinqX0mJAKeEaGWjZjBkMA4GA1UdDwEB/wQEAwIB
      BjASBgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdDgQWBBR+Vi9NZKR7UnNuewsk8tdy
      kkUSOzAfBgNVHSMEGDAWgBSEaEJ/xxR/HEip527Pbq8Xb/sHizAKBggqhkjOPQQD
      AgNJADBGAiEAiQPffBe7lGVbQeaH7iZguYXpHtw6IIVR96T+d+fRXqICIQDwxcB+
      ZDHSV91FBejgf9ELMOwXHaMjqQ+Cf1yLJlt5NQ==
      -----END CERTIFICATE-----
    ''
    ''
      -----BEGIN CERTIFICATE-----
      MIIBozCCAUqgAwIBAgIRAN9K3hY0YiYaTDWGHixBgTcwCgYIKoZIzj0EAwIwMDEu
      MCwGA1UEAxMlQ2FkZHkgTG9jYWwgQXV0aG9yaXR5IC0gMjAyNSBFQ0MgUm9vdDAe
      Fw0yNTA1MDgwMzMzNTFaFw0zNTAzMTcwMzMzNTFaMDAxLjAsBgNVBAMTJUNhZGR5
      IExvY2FsIEF1dGhvcml0eSAtIDIwMjUgRUNDIFJvb3QwWTATBgcqhkjOPQIBBggq
      hkjOPQMBBwNCAARWxUzBbeufQRmXHHy2/6gy7RIMFQ/cXNh816oLfme6NR0RTIIo
      xUCLFJou4ovNJXPLN9z8PW9hnAG780E8L9j4o0UwQzAOBgNVHQ8BAf8EBAMCAQYw
      EgYDVR0TAQH/BAgwBgEB/wIBATAdBgNVHQ4EFgQUhGhCf8cUfxxIqeduz26vF2/7
      B4swCgYIKoZIzj0EAwIDRwAwRAIgfnjfXv6GDZRXBZ6hvrxX7b6W55hgnqc4bl++
      tpiPfRkCIFZHw8YOWc3y7xv1exxl005bCvd0XkxZiSmWDyB7AQrH
      -----END CERTIFICATE-----
    ''
  ];

  security.pki.certificateFiles = [
    config.environment.etc."client_ca.pem".source
  ];

  environment.etc."client_ca.pem" = {
    text = ''
      -----BEGIN CERTIFICATE-----
      MIIDEzCCAfugAwIBAgIUKEdh6YtrwFnAimRzB35ONfuIK8QwDQYJKoZIhvcNAQEL
      BQAwGTEXMBUGA1UEAwwOVGVzdCBDbGllbnQgQ0EwHhcNMjUwNzI1MTc1MDU4WhcN
      MjYwNzI1MTc1MDU4WjAZMRcwFQYDVQQDDA5UZXN0IENsaWVudCBDQTCCASIwDQYJ
      KoZIhvcNAQEBBQADggEPADCCAQoCggEBAMm+SYpUwXkWzCIPBggAjWieV0Q976Mu
      f2myIJRhJEQt3aOUafQzxjkfEfIEMe9QwoevVO72j+MRZV57OPYD55bl14buXSBg
      oeSaCw8TkUY7++AeGeVFckA816EWiAyI6wn3w0DMJ46KL6bmwBTvydIna6GTTfQv
      FpKGoJGP22r0W4SAPPGgGTXA1oSYmow45jEHi779lE+x6YRnS41B1Enf0gqbah+k
      wPkao/MSCd837U7u17d9LqBo3jj0FBGzxIVgW87jWzXN5OEnbIfx8ZQnV9Se8MCA
      vIfZme8LyK72O78cYnTzutbvvqs7XgVmMKQ2UGA09xyXd+YwaqVMyD8CAwEAAaNT
      MFEwHQYDVR0OBBYEFLhCPhYefVXpYY34oZ4Qe7xzDH0EMB8GA1UdIwQYMBaAFLhC
      PhYefVXpYY34oZ4Qe7xzDH0EMA8GA1UdEwEB/wQFMAMBAf8wDQYJKoZIhvcNAQEL
      BQADggEBACAITUcjg414nNYE2pPGSzkvsP6uebJo9WdY7sLxjPWDd8dILoAmvplT
      HVtFCYFVHoXajPAQUYItx9LAaSbFrPJGM5tNkIK8dUu0S+IOq7tclcpfcarHDp7W
      UD6bgEpYEChYUIoUT312fVnvSy7CPMQN3danEmDTCa3/7a8RbXrYOp7dFFiDy+T/
      kVGONlnX7HsZOQACkuUQ/eKsaRXm0sgT0Rjwy1PYFzeoc6lzzZ2/kMfV5HXmLn8A
      qNC96RXLul2bv03ybVI8+26vvCi4DoDzMP3ZFk8m73MMkF157H+L2ZUQcjrbIuLF
      8hrSIJ/swN00HVc4UN35AWZaE4dakGU=
      -----END CERTIFICATE-----
    '';
    mode = "0655";
  };

  # Headscale ACL for subnet routing
  #environment.etc."headscale/acl.yaml" = {
  #  text = ''
  #    acls:
  #      - action: accept
  #        src:
  #          - "*"
  #        dst:
  #          - "192.168.0.0/24:*"
  #  '';
  #  mode = "0644";
  #};
 
  environment.etc."dnscrypt-proxy/cloaking-rules.txt".text = ''*.mynixoshome.* 192.168.0.38'';
  # 
  #environment.etc."dnscrypt-proxy/forwarding-rules.txt".text = ''jellyfin.home 192.168.0.18'';
  #
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

  # Encrypted DNS
  services.dnscrypt-proxy2 = {
    enable = true;
    # Settings reference:
    # https://github.com/DNSCrypt/dnscrypt-proxy/blob/master/dnscrypt-proxy/example-dnscrypt-proxy.toml
    settings = {
      ipv6_servers = true;
      require_dnssec = true;
      cache = true;
      query_log.file = "/var/log/dnscrypt-proxy/query.log";
      cloaking_rules = "/etc/dnscrypt-proxy/cloaking-rules.txt";
      #forwarding_rules = "/etc/dnscrypt-proxy/forwarding-rules.txt";
      #ipv4_servers = true;
      #block_undelegated = false;
      #dnscrypt_servers = true;
      listen_addresses = [ "0.0.0.0:53" ];
      # Add this to test if dnscrypt-proxy is actually used to resolve DNS requests
      sources.public-resolvers = {
        urls = [
          "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
          "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
        ];
        cache_file = "/var/cache/dnscrypt-proxy/public-resolvers.md";
        minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
      };
      # You can choose a specific set of servers from https://github.com/DNSCrypt/dnscrypt-resolvers/blob/master/v3/public-resolvers.md
      #server_names = [ "google" ];
      server_names = [ "cloudflare" ];
      #static = {
      #  "mealie.home" = {
      #    stamp = "sdns://gAMBAAABAAAAAAABAAHCoAAAEAAAABAAAACw";
      #  };
      #  "jellyfin.home" = {
      #    stamp = "sdns://AQcAAAAAAAAADDE5Mi4xNjguMC4xOAAQMi5kbnNjcnlwdC1jZXJ0Lg";
      #  };
      #};
    };
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # HOMELAB
  services.mealie = {
    enable = true;
    settings = {
      ALLOW_SIGNUP = "true";
      SECURITY_MAX_LOGIN_ATTEMPTS = 100;
      SECURITY_USER_LOCKOUT_TIME = 1;
    };
  };

  services.mullvad-vpn.enable = false;

  services.actual = {
    enable = true;
    settings = {
      port = 3001;
    };
  };

  services.jellyfin = {
    enable = true;
    user = "cameron";
  };

  services.tailscale = {
    enable = true;
    openFirewall = true;
    useRoutingFeatures = "server";
  };

  #services.jellyseerr = {
  #  enable = true;
  #  openFirewall = false;
  #};

  #services.sonarr = {
  #  enable = true;
  #  openFirewall = false;
  #};

  #services.prowlarr = {
  #  enable = true;
  #  openFirewall = false;
  #};

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
    settings = {
      PAPERLESS_URL = "https://paperless.mynixoshome.io";
    };
  };

  #services.silverbullet = {
  #  enable = true;
  #  openFirewall = true;
  #  user = "cameron";
  #  envFile = "/etc/silverbullet.env";
  #};

  #services.headscale = {
  #  enable = true;
  #  address = "0.0.0.0";
  #  port = 8080;
  #  settings = {
  #    server_url = "https://headscale.mynixoshome.io";
  #    dns = {
  #      base_domain = "mynixoshome.io";
  #    };
  #    ip_prefixes = [ "100.64.0.0/10" ];
  #    policy.path = "/etc/headscale/acl.yaml";
  #  };
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

  #services.minecraft-server = {
  #  enable = true;
  #  eula = true;
  #  openFirewall = true; # Opens the port the server is running on (by default 25565 but in this case 43000)
  #  declarative = true;
  #  #whitelist = {
  #  #  # This is a mapping from Minecraft usernames to UUIDs. You can use https://mcuuid.net/ to get a Minecraft UUID for a username
  #  #  #username1  = "2e73072d-c5ef-4ae3-9d1b-d28166cda3c2"; #czzzAR
  #  #  # username2 = "yyyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyyyy";
  #  #};
  #  serverProperties = {
  #    level-name = "test";
  #    player-idle-timeout = 5;
  #    allow-flight = false;
  #    server-port = 43000;
  #    difficulty = 3;
  #    gamemode = 0;
  #    pvp = true;
  #    max-players = 5;
  #    motd = "Mother Fucking Minecraft Self Hosted Server";
  #    # white-list = true;
  #    allow-cheats = false;
  #    #resource-pack = "http://resourcepack.local/dramatic_skys.zip";
  #    #resource-pack-id = "b7bed5d1-d396-47ba-9974-c90784a4e123";
  #    #resource-pack-sha1 = "7dc1a5857421a201ad27c356946927ec921ed896";
  #    #resource-pack-prompt = "test!";
  #  };
  #  # jvmOpts = "-Xms4092M -Xmx4092M -XX:+UseG1GC -XX:+CMSIncrementalPacing -XX:+CMSClassUnloadingEnabled -Xmx2048M -Xms2048M -Djava.net.preferIPv4Stack=true";
  #};

  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    guiAddress = "0.0.0.0:8384";
    settings.options.localAnnounceEnabled = true;
  };

  #services.factorio = {
  #  enable = true;
  #  openFirewall = true;
  #  game-name = "nixlan";
  #  game-password = "asdfasdf";
  #  description = "Nixos hosted factorio server";
  #};

  #services.gitlab = {
  #  enable = true;
  #  #port = 443;
  #  #https = true;
  #  databasePasswordFile = pkgs.writeText "dbPassword" "zgvcyfwsxzcwr85l";
  #  initialRootPasswordFile = pkgs.writeText "rootPassword" "Jdnedejdnede6363!";
  #  secrets = {
  #    secretFile = pkgs.writeText "secret" "Aig5zaic";
  #    otpFile = pkgs.writeText "otpsecret" "Riew9mue";
  #    dbFile = pkgs.writeText "dbsecret" "we2quaeZ";
  #    jwsFile = pkgs.runCommand "oidcKeyBase" {} "${pkgs.openssl}/bin/openssl genrsa 2048 > $out";
  #    activeRecordPrimaryKeyFile = pkgs.writeText "activeRecordPrimaryKey" (builtins.readFile (pkgs.runCommand "activeRecordPrimaryKey" {} "head -c32 /dev/urandom | base64 | head -c32 > $out"));
  #    activeRecordDeterministicKeyFile = pkgs.writeText "activeRecordDeterministicKey" (builtins.readFile (pkgs.runCommand "activeRecordDeterministicKey" {} "head -c32 /dev/urandom | base64 | head -c32 > $out"));
  #    activeRecordSaltFile = pkgs.writeText "activeRecordSalt" (builtins.readFile (pkgs.runCommand "activeRecordSalt" {} "head -c32 /dev/urandom | base64 | head -c32 > $out"));
  #  };
  #};

  systemd.services.gitlab-backup.environment.BACKUP = "dump";

  #services.ollama = {
  #  enable = true;
  #  port = 11434;
  #  acceleration = "rocm";
  #  openFirewall = true;
  #};

  services.searx = {
    enable = true;
    settings = {
      server.port = 8084;
      server.bind_address = "0.0.0.0";
      server.secret_key = "@SEARX_SECRET_KEY@";
      engines = lib.singleton
      {
        name = "wolframalpha";
        shortcut = "wa";
        api_key = "@WOLFRAM_API_KEY@";
        engine = "wolframalpha_api";
      };
    };
  };

  services.navidrome = {
    enable = true;
    settings = {
      MusicFolder = "/home/cameron/Music";
    };
  };

  services.caddy = {
    enable = true;
    globalConfig = ''
      skip_install_trust
    '';
    virtualHosts = {
      "mealie.mynixoshome.io" = {
        extraConfig = ''
          tls internal {
            client_auth {
              mode require_and_verify
              trust_pool file /etc/client_ca.pem
            }
          }
          reverse_proxy localhost:9000
        '';
      };
      "dashboard.mynixoshome.io" = {
        extraConfig = ''
          tls internal {
            client_auth {
              mode require_and_verify
              trust_pool file /etc/client_ca.pem
            }
          }
          reverse_proxy localhost:8082
        '';
      };
      "jellyfin.mynixoshome.io" = {
        extraConfig = ''
          tls internal {
            client_auth {
              mode require_and_verify
              trust_pool file /etc/client_ca.pem
            }
          }
          reverse_proxy localhost:8096
        '';
      };
      "jellyseer.mynixoshome.io" = {
        extraConfig = ''
          tls internal {
            client_auth {
              mode require_and_verify
              trust_pool file /etc/client_ca.pem
            }
          }
          reverse_proxy localhost:5055
        '';
      };
      "sonarr.mynixoshome.io" = {
        extraConfig = ''
          tls internal {
            client_auth {
              mode require_and_verify
              trust_pool file /etc/client_ca.pem
            }
          }
          reverse_proxy localhost:8989
        '';
      };
      "prowlarr.mynixoshome.io" = {
        extraConfig = ''
          tls internal {
            client_auth {
              mode require_and_verify
              trust_pool file /etc/client_ca.pem
            }
          }
          reverse_proxy localhost:9696
        '';
      };
      "vaultwarden.mynixoshome.io" = {
        extraConfig = ''
          tls internal {
            client_auth {
              mode require_and_verify
              trust_pool file /etc/client_ca.pem
            }
          }
          reverse_proxy localhost:8222
        '';
      };
      "navidrome.mynixoshome.io" = {
        extraConfig = ''
          tls internal {
            client_auth {
              mode require_and_verify
              trust_pool file /etc/client_ca.pem
            }
          }
          reverse_proxy localhost:4533
        '';
      };
      "audiobookshelf.mynixoshome.io" = {
        extraConfig = ''
          tls internal {
            client_auth {
              mode require_and_verify
              trust_pool file /etc/client_ca.pem
            }
          }
          reverse_proxy localhost:8000
        '';
      };
      "paperless.mynixoshome.io" = {
        extraConfig = ''
          tls internal {
            client_auth {
              mode require_and_verify
              trust_pool file /etc/client_ca.pem
            }
          }
          reverse_proxy localhost:28981
        '';
      };
      #"home-assistant.home" = {
      #  extraConfig = ''
      #    tls internal {
      #      client_auth {
      #        mode require_and_verify
      #        trust_pool file /etc/client_ca.pem
      #      }
      #    }
      #    reverse_proxy localhost:8123
      #  '';
      #};
      "pinchflat.mynixoshome.io" = {
        extraConfig = ''
          tls internal {
            client_auth {
              mode require_and_verify
              trust_pool file /etc/client_ca.pem
            }
          }
          reverse_proxy localhost:8945
        '';
      };
      "immich.mynixoshome.io" = {
        extraConfig = ''
          tls internal {
            client_auth {
              mode require_and_verify
              trust_pool file /etc/client_ca.pem
            }
          }
          reverse_proxy localhost:2283
        '';
      };
      "open.mynixoshome.io" = {
        extraConfig = ''
          tls internal {
            client_auth {
              mode require_and_verify
              trust_pool file /etc/client_ca.pem
            }
          }
          reverse_proxy localhost:8083
        '';
      };
      "qbit.mynixoshome.io" = {
        extraConfig = ''
          tls internal {
            client_auth {
              mode require_and_verify
              trust_pool file /etc/client_ca.pem
            }
          }
          reverse_proxy localhost:8085
        '';
      };
      "n8n.mynixoshome.io" = {
        extraConfig = ''
          tls internal {
            client_auth {
              mode require_and_verify
              trust_pool file /etc/client_ca.pem
            }
          }
          reverse_proxy localhost:5678
        '';
      };
      "syncthing.mynixoshome.io" = {
        extraConfig = ''
          tls internal {
            client_auth {
              mode require_and_verify
              trust_pool file /etc/client_ca.pem
            }
          }
          reverse_proxy localhost:8384
        '';
      };
      #"uptime-kuma.mynixoshome.io" = {
      #  extraConfig = ''
      #    tls internal {
      #      client_auth {
      #        mode require_and_verify
      #        trust_pool file /etc/client_ca.pem
      #      }
      #    }
      #    reverse_proxy localhost:4000
      #  '';
      #};
      "vikunja.mynixoshome.io" = {
        extraConfig = ''
          tls internal {
            client_auth {
              mode require_and_verify
              trust_pool file /etc/client_ca.pem
            }
          }
          reverse_proxy localhost:3456
        '';
      };
      "ntfy.mynixoshome.io" = {
        extraConfig = ''
          tls internal {
            client_auth {
              mode require_and_verify
              trust_pool file /etc/client_ca.pem
            }
          }
          reverse_proxy localhost:8081
        '';
      };
      "silver.mynixoshome.io" = {
        extraConfig = ''
          tls internal {
            client_auth {
              mode require_and_verify
              trust_pool file /etc/client_ca.pem
            }
          }
          reverse_proxy localhost:3000
        '';
      };
      "actual.mynixoshome.io" = {
        extraConfig = ''
          tls internal {
            client_auth {
              mode require_and_verify
              trust_pool file /etc/client_ca.pem
            }
          }
          reverse_proxy localhost:3001
        '';
      };
      "searxng.mynixoshome.io" = {
        extraConfig = ''
          tls internal {
            client_auth {
              mode require_and_verify
              trust_pool file /etc/client_ca.pem
            }
          }
          reverse_proxy localhost:8084
        '';
      };
      "gitlab.mynixoshome.io" = {
        extraConfig = ''
          tls internal {
            client_auth {
              mode require_and_verify
              trust_pool file /etc/client_ca.pem
            }
          }
          reverse_proxy unix//run/gitlab/gitlab-workhorse.socket
        '';
      };
      "files.mynixoshome.io" = {
        extraConfig = ''
          tls internal {
            client_auth {
              mode require_and_verify
              trust_pool file /etc/client_ca.pem
            }
          }
          root * /var/www
          file_server browse
        '';
      };
      "headscale.mynixoshome.io" = {
        extraConfig = ''
          tls internal {
            client_auth {
              mode require_and_verify
              trust_pool file /etc/client_ca.pem
            }
          }
          reverse_proxy localhost:8080
        '';
      };
    };
  };

  services.homepage-dashboard = {
    enable = true;
    openFirewall = false;
    allowedHosts = "dashboard.mynixoshome.io";
    widgets = [
      {
        resources = {
          cpu = true;
          disk = "/";
          memory = true;
          network = true;
        };
      }
      {
        search = {
          provider = "brave";
          focus = true;
          showSearchSuggestions = true;
        };
      }
  ];
    services = [
      {
        "Media" = [
          {
            "Jellyfinn" = {
              description = "Free Software Media System - Server Backend & API";
              href = "https://jellyfin.mynixoshome.io";
            };
          }
          #{
          #  "Jellyseer" = {
          #    description = "Open-source media request and discovery manager for Jellyfin";
          #    href = "https://jellyseer.mynixoshome.io";
          #  };
          #}
          #{
          #  "Sonarr" = {
          #    description = "Smart PVR (Personal Video Recorder) for bit users";
          #    href = "https://sonarr.mynixoshome.io";
          #  };
          #}
          #{
          #  "Prowlarr" = {
          #    description = "Index Manager/Proxy built to integrate with PVR apps";
          #    href = "https://prowlarr.mynixoshome.io";
          #  };
          #}
          {
            "Pinchflat" = {
              description = "Your next YouTube media manager";
              href = "https://pinchflat.mynixoshome.io";
            };
          }
          {
            "AudioBookShelf" = {
              description = "Self-hosted audiobook and podcast server";
              href = "https://audiobookshelf.mynixoshome.io";
            };
          }
          {
            "Navidrome" = {
              description = "Self-hosted music (Spotify replacement) server";
              href = "https://navidrome.mynixoshome.io";
            };
          }
          {
            "Immich" = {
              description = "High performance self-hosted photo and video management solution";
              href = "https://immich.mynixoshome.io";
            };
          }
        ];
      }
      {
        "Localhost" = [
          #{
          #  "Home Assistant" = {
          #    description = "Open source home automation that puts local control and privacy first";
          #    href = "https://home-assistant.home";
          #  };
          #}
          {
            "Vikunja" = {
              description = "The to-do app to organize your life.";
              href = "https://vikunja.mynixoshome.io";
            };
          }
          {
            "Searxng" = {
              description = "Privacy-respecting, hackable metasearch engine";
              href = "https://searxng.mynixoshome.io";
            };
          }
          {
            "Mealie" = {
              description = "Self hosted recipe manager and meal planner";
              href = "https://mealie.mynixoshome.io";
            };
          }
          {
            "Actual" = {
              description = "A local-first personal finance app";
              href = "https://actual.mynixoshome.io";
            };
          }
          #{
          #  "Uptime-kuma" = {
          #    description = "A fancy self-hosted monitoring tool";
          #    href = "https://uptime-mynixoshome.io.home";
          #  };
          #}
          #{
          #  "Open-webui" = {
          #    description = "Chat UI for Self Hosted LLMs";
          #    href = "https://open.mynixoshome.io";
          #  };
          #}
          {
            "Paperless-ngx" = {
              description = "Community-supported supercharged document management system: scan, index and archive all your documents";
              href = "https://paperless.mynixoshome.io";
            };
          }
          {
            "Vaultwarden" = {
              description = "Unofficial Bitwarden compatible server written in Rust";
              href = "https://vaultwarden.mynixoshome.io";
            };
          }
        ];
      }
      {
        "CICD Automation" = [
          #{
          #  "GitLab" = {
          #    description = "Self hosted GitLab server; code repository and cicd experiments";
          #    href = "https://gitlab.mynixoshome.io";
          #  };
          #}
          {
            "Github" = {
              description = "Link to personal github repo";
              href = "https://github.com/cameroncarlg";
            };
          }
          #{
          #  "ntfy" = {
          #    description = "Automated multi-push notification system";
          #    href = "https://ntfy.mynixoshome.io";
          #  };
          #}
          #{
          #  "n8n" = {
          #    description = "Automation GUI for Self Hosted LLMs";
          #    href = "https://n8n.mynixoshome.io";
          #  };
          #}
          {
            "Syncthing" = {
              description = "Open Source Continuous File Synchronization";
              href = "https://syncthing.mynixoshome.io";
            };
          }
          {
            "Qbit" = {
              description = "Automation GUI for Self Hosted LLMs";
              href = "https://qbit.mynixoshome.io";
            };
          }
          {
            "File Server" = {
              description = "Filer server for files between linux and windows";
              href = "https://files.mynixoshome.io";
            };
          }
        ];
      }
    ];
  };

  #services.open-webui = {
  #  enable = true;
  #  openFirewall = false;
  #  port = 8083;
  #};

  #services.n8n = {
  #  enable = true;
  #  openFirewall = false;
  #};

  #services.jmusicbot = {
  #  enable = true;
  #};

  #services.uptime-kuma = {
  #  enable = true;
  #  settings = {
  #    #NODE_EXTRA_CA_CERTS = {
  #    #  _type = "literalExpression";

  #    #  #text = "config.security.pki.caBundle";
  #    #  text = "etc/ssl";
  #    #};
  #    PORT = "4000";
  #  };
  #};

  services.vikunja = {
    enable = true;
    frontendScheme = "https";
    frontendHostname = "vikunja";
  };

  #services.ntfy-sh = {
  #  enable = true;
  #  settings = {
  #    listen-http = ":8081";
  #    behind-proxy = true;
  #    base-url = "https://ntfy.mynixoshome.io";
  #  };
  #};

  #services.qbittorrent = {
  #  enable = true;
  #  webuiPort = "8085";
  #  openFirewall = true;
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

  users.users.caddy.extraGroups = [ "gitlab" ];

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "cameron";

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Install firefox.
  programs.firefox.enable = true;
  programs.firefox.policies.Certificates.ImportEnterpriseRoots = true;

  # Install fish.
  programs.fish.enable = true;

  # Install steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-original"
    "steam-unwrapped"
    "steam-run"
  ];

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
    #claude-code
    tailscale
    #python3
    aichat
    remmina
    discord
    #python3Packages.discordpy
    #uv
    #baobab
    wireguard-tools
    #parrot
    #gitlab
    nushell
    #claude-code
    privoxy
    #minecraft
    minecraft-server
    #inputs.helix.packages."${pkgs.system}".helix

    # Homelab 
    #home-assistant
    syncthing
    #ntfy-sh
    #meshcentral
    #firefly-iii
    #navidrome
    #fosrl-pangolin
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

  # Enable Docker
  #virtualisation.docker.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 80 443 8191 53 28981 43000 8083 8945 3001 4000 3456 8384 8081 25565 6806 ];
  networking.firewall.allowedUDPPorts = [ 80 443 8191 53 28981 43000 8083 8945 3001 4000 3456 8384 8081 25565 6806 5353 51820 41641 ];
  networking.firewall.trustedInterfaces = [ "tailscale0" ];
  networking.firewall.checkReversePath = "loose";
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
