{ inputs, pkgs, ... }:

{
  imports =
    [
      inputs.nix-minecraft.nixosModules.minecraft-servers
    ];

    nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

    services.minecraft-servers = {
    enable = true;
    eula = true;
    #openFirewall = true;
    servers.fabric = {
      enable = true;
      serverProperties = {
        server-port = 43000;
        motd = "gyms added?";
        admin-slot = true;
        public = true;
        allow-cheats = true;
        gamemode = "creative";
      };

      # Specify the custom minecraft server package
      package = pkgs.fabricServers.fabric-1_21_1.override {
        #loaderVersion = "0.16.10";
        #loaderVersion = "0.17.3";
        loaderVersion = "0.18.4";
      }; # Specific fabric loader version

      symlinks =
      let
        modpack = (pkgs.fetchPackwizModpack {
          #url = "https://raw.githubusercontent.com/cameroncarlg/packwiz_modpacks/refs/heads/main/modrinth_cobblemon/pack.toml";
          #packHash = "sha256-K68edzT4VvMLA6IrJBQLWu2h7BYqa54yJOYwJJsyp5E=";
          url = "https://raw.githubusercontent.com/cameroncarlg/packwiz_modpacks/refs/heads/main/cobblemon2/pack.toml";
          packHash = "sha256-K68edzT4VvMLA6IrJBQLWu2h7BYqa54yJOYwJJsyp5E=";
        });
      in
      {
        "mods" = "${modpack}/mods";
        #mods = pkgs.linkFarmFromDrvs "mods" (
        #  builtins.attrValues {
        #    Fabric-API = pkgs.fetchurl {
        #      url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/yGAe1owa/fabric-api-0.116.9%2B1.21.1.jar";
        #      sha512 = "e643876079b950aef9aad3eee8d27046305895e8d0f595f7f95010839adeaa25c55a6dc8624ccfba1201194d6598fcbc11f23a7a553ccefbb8c0ceacf388bb79";
        #    };
        #    ModMenu = pkgs.fetchurl {
        #      url = "https://cdn.modrinth.com/data/mOgUt4GM/versions/YIfqIJ8q/modmenu-11.0.3.jar";
        #      sha512 = "4c6387a059c7ac9028acc3d78124af02a4495bef2c16783bbffe5bf449067daf2620708fd57f8725e46f0c34d0f571adf60f0869742bfe7f6101ddf13a2a87da";
        #    };
        #    #Cobbleverse = pkgs.fetchurl {
        #    #  url = "https://cdn.modrinth.com/data/Jkb29YJU/versions/jImAfjVc/COBBLEVERSE%201.7.30.mrpack";
        #    #  sha512 = "05ef8ae2ed3eef17516e5bafcc303e67e7f9d1176d3343eacbcca01d2afea045aeb0b405e06ac370fc8eacf0f936d85049995b9620b0abfd129cf4b7c2e5a946";
        #    #};
        #    Cobblemon = pkgs.fetchurl {
        #      url = "https://cdn.modrinth.com/data/MdwFAVRL/versions/kF7CvxTo/Cobblemon-fabric-1.7.3%2B1.21.1.jar";
        #      sha512 = "7b5376f5f48177db53790237b6fb25378806972b5d3b756151b4d8f2d3c27238d6b587b77da422bc1780bfd358b4702e74369fd82cef2a35301b4b68a2f13c2e";
        #    };
        #    #Cobblenav = pkgs.fetchurl {
        #    #  url = "https://cdn.modrinth.com/data/bI8Nt3uA/versions/VjtSuwwW/cobblenav-fabric-2.2.5.jar";
        #    #  sha512 = "1679a4bd6769b05c68f2d0257eaf663ec505beeb2505461fd4ce29eba844993bdc5452e2cb07ad4d8cd98cb7460015196723a272baf3039641fb205ad1eedfeb";
        #    #};
        #    #MegaShowdown = pkgs.fetchurl {
        #    #  url = "https://cdn.modrinth.com/data/SszvX85I/versions/Tw2CurAX/Cobblemon_MegaShowdown-9.8.0-release-fabric.jar";
        #    #  sha512 = "cca87bf0ee2319fe2ffe463aaaf353a002c241a7ff1557f500d892d6d2e9487e375def775dfb1b28295c0e9e76ffdf7a82b4f6cf633078fa984472f054adf26c";
        #    #};
        #    #Trinkets = pkgs.fetchurl {
        #    #  url = "https://cdn.modrinth.com/data/5aaWibi9/versions/JagCscwi/trinkets-3.10.0.jar";
        #    #  sha512 = "3ea846c945a0559696501ff65b373c8ee8fd9b394604e9910b4ed710c3e07cadc674a615a2c3b385951a42253a418201975df951b3100053ed39afadc70221c9";
        #    #};
        #  }
        #);
      };
    };
  };
}

