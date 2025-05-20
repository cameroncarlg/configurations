{ lib, pkgs, ... }:

{
  imports = [
    ../../modules/common
  ];

  #Home Manager needs to know where to manage

  home.username = "cameron";
  home.homeDirectory = "/Users/cameron";

  # Home-manager needs time to catch up to nixpkgs version
  # Turn this to false to suppress warning message
  #home.enableNixpkgsReleaseCheck = false;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # Install Nix packages into your $USER env
  home.packages = with pkgs; [
    neovim # Modern Unix 'vi'
    htop # Modern Unix 'top'
    btop # Even ~more~ Modern Unix 'top'
    bmon # Modern Unix 'iftop'
    chafa # Terminal image viewer
    tldr # Modern Unix 'man'
    tokei # Modern Unix 'wc' for code
    wthrr # Terminal Weather App
    gping # Modern Unix 'ping'
    hr # Terminal horizontal rule
    fd # Modern Unix 'find'
    hyperfine # Terminal benchmarking
    iperf3 # Terminal network benchmarking
    mtr # Modern Unix 'traceroute'
    wget # Terminal HTTP client
    wget2 # Terminal HTTP client
    procs # Modern Unix 'ps'
    fastfetch # Modern PC info
    neo-cowsay # Terminal ASCII cow
    speedtest-go # Terminal speedtest
    terminal-parrot # Terminal ASCII parrot
    #nyancat # Modern Unix nyancat
    cpufetch # Terminal CPU info
    bat # Modern Unix 'cat'
    nix-prefetch-git # TBD
    nix-prefetch-github # TBD
    nix-prefetch
    nh # Yet another Nix helper
    gh # GitHub CLI
    tig # Text mode interface for git
    #nerdfonts # NerdFonts
    fira-code # FiraCode
    openvpn
    nmap
    nil
    nixfmt-rfc-style
    openssl
    #traceroute
    #neofetch

  #  # Broken

  #  # lazydocker # Terminal docker interface (depreciated I think)
  #  # dotacat # Modern Unix lolcat
  #  # m-cli # TBD

  #  # Unsupported on MacOS

  #  # vlc # VLC Media Player
  #  # asciicam # Terminal webcam
  #  # asciinema-agg # Convert asciinema to .gif
  #  # asciinema # Terminal recorder
  #  # bandwhich # Modern Unix 'iftop'
  #    
  #  # # It is sometimes useful to fine-tune packages, for example, by applying
  #  # # overrides. You can do that directly here, just don't forget the
  #  # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
  #  # # fonts?
  #  # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

  #  # # You can also create simple shell scripts directly inside your
  #  # # configuration. For example, this adds a command 'my-hello' to your
  #  # # environment:
  #  (pkgs.writeShellScriptBin "my-hello" ''
  #    echo "Hello, ${config.home.username}!"
  #  '')

  #  (pkgs.writeShellScriptBin "fetchsha" ''
  #    nix-prefetch-github-latest-release --meta -v $1 $2
  #  '')
  ];

  programs.nushell = {
    enable = true;
    shellAliases = {
      sw = "sudo darwin-rebuild switch --flake /Users/cameron/configurations";
      hxc = "sudo hx /Users/cameron/configurations/hosts/macbook/home.nix";
      hxcv = "sudo hx /Users/cameron/configurations/hosts/macbook/configuration.nix";
      lg = "lazygit";
      ll = "ls -la";
     };
  };

  programs.starship = {
    enable = true;
    enableNushellIntegration = true;
    settings = {
      add_newline = true;
      format = lib.concatStrings [
        "🍎 $directory$git_branch> "
        "$line_break"
      ];
    };
  };

  programs.fish = {
    enable = true;
    shellAbbrs = {
      sw = "sudo darwin-rebuild switch --flake /Users/cameron/configurations";
      wthr = "wthrr -u f,12h,in";
      ff = "fastfetch";
      cat = "bat";
      ld = "lazydocker";
      lg = "lazygit";
      # ll = "br -sdp";
    };
    functions = {
      # trash = "mv $argv[1] $HOME/.Trash";
      hxc = "sudo hx /Users/cameron/configurations/hosts/macbook/home.nix";
      hxcv = "sudo hx /Users/cameron/configurations/hosts/macbook/configuration.nix";
      # code = "codium";
      cd = "builtin cd $argv; and ls";
    };
    interactiveShellInit = "
      set fish_greeting
    ";
    plugins = [
      {
        name = "fzf.fish";
        src = pkgs.fetchFromGitHub {
          owner = "PatrickF1";
          repo = "fzf.fish";
          rev = "8920367cf85eee5218cc25a11e209d46e2591e7a";
          hash  = "sha256-T8KYLA/r/gOKvAivKRoeqIwE2pINlxFQtZJHpOy9GMM=";
        };
      }
      {
        name = "autopair.fish";
        src = pkgs.fetchFromGitHub {
          owner = "jorgebucaran";
          repo = "autopair.fish";
          rev = "244bb1ebf74bf944a1ba1338fc1026075003c5e3";
          hash = "sha256-s1o188TlwpUQEN3X5MxUlD/2CFCpEkWu83U9O+wg3VU=";
        };
      }
      {
        name = "done";
        src = pkgs.fetchFromGitHub {
          owner = "franciscolourenco";
          repo = "done";
          rev = "eb32ade85c0f2c68cbfcff3036756bbf27a4f366";
          hash = "sha256-DMIRKRAVOn7YEnuAtz4hIxrU93ULxNoQhW6juxCoh4o=";
        };
      }
    ];
  };

  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local wezterm = require 'wezterm'
      local config = wezterm.config_builder()

      config.color_scheme = 'Catppuccin Mocha'
      config.use_fancy_tab_bar = false
      config.show_new_tab_button_in_tab_bar = false
      config.window_background_opacity = 0.925
      config.mouse_wheel_scrolls_tabs = true
      config.font = wezterm.font("Fira Code")
      config.enable_scroll_bar = true
      config.hide_mouse_cursor_when_typing = false

      config.keys = {
        { key = 'Enter', mods = 'CMD', action = wezterm.action.SplitHorizontal {domain = 'CurrentPaneDomain' }},
        { key = 'Enter', mods = 'CMD|SHIFT', action = wezterm.action.SplitVertical {domain = 'CurrentPaneDomain' }},
        { key = 't', mods = 'CMD|SHIFT', action = wezterm.action.ActivateTabRelative(-1) },
        { key = 'w', mods = 'CMD', action = wezterm.action.CloseCurrentPane {confirm = true }},
        { key = 'w', mods = 'CMD|SHIFT', action = wezterm.action.CloseCurrentTab {confirm = true }},
        { key = 'j', mods = 'CMD', action = wezterm.action.ActivatePaneDirection 'Next' },
        { key = 'k', mods = 'CMD', action = wezterm.action.ActivatePaneDirection 'Prev' },
        { key = 'h', mods = 'CMD', action = wezterm.action.ActivatePaneDirection 'Left' },
        { key = 'l', mods = 'CMD', action = wezterm.action.ActivatePaneDirection 'Right' },
        { key = 'h', mods = 'CMD|SHIFT', action = wezterm.action.AdjustPaneSize { 'Left', 5 }},
        { key = 'j', mods = 'CMD|SHIFT', action = wezterm.action.AdjustPaneSize { 'Down', 5 }},
        { key = 'k', mods = 'CMD|SHIFT', action = wezterm.action.AdjustPaneSize { 'Up', 5 }},
        { key = 'l', mods = 'CMD|SHIFT', action = wezterm.action.AdjustPaneSize { 'Right', 5 }},
        { key = 'n', mods = 'CMD', action = wezterm.action.TogglePaneZoomState },
        { key = 'p', mods = 'CMD|SHIFT', action = wezterm.action.ToggleFullScreen },
      }
      return config
    '';

  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/cameron/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "hx";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
