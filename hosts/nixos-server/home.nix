{ pkgs, ... }:

{
  imports = [
    ../../modules/common
    ../../modules/linux
  ];

  #Home Manager needs to know where to manage

  home.username = "cameron";
  home.homeDirectory = "/home/cameron";

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
    nyancat # Modern Unix nyancat
    cpufetch # Terminal CPU info
    bat # Modern Unix 'cat'
    nix-prefetch-git # TBD
    nix-prefetch-github # TBD
    nix-prefetch
    nh # Yet another Nix helper
    gh # GitHub CLI
    tig # Text mode interface for git
    fira-code # FiraCode
    openvpn
    nil
    nixfmt-rfc-style
    openssl
    dig
    yazi
    #gemini-cli
    #nmap
    #nerdfonts # NerdFonts
    #neofetch
    #traceroute
    # broot # Terminal File System navigator

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
  # 
    (pkgs.writeShellScriptBin "vpnc" ''
      curl -sS https://am.i.mullvad.net/json
      '')

    #(pkgs.writers.writeNuBin "test" (builtins.readFile ./nulix-wezterm.nu))
    (pkgs.writers.writeNuBin "monitor" ''
      try {
          print "Creating named pipe 'myfifo'..."

          mkfifo myfifo

          print "✅ Pipe created. Now listening for output."
          print "In another terminal, run your command and redirect its output:"
          print "e.g., cargo run > myfifo"
          print "Press Ctrl+C to stop and clean up."
          print "---"

          try {
              tail -f myfifo
          } catch {
              # This block catches the "Operation interrupted" error when you press Ctrl+C.
              # By leaving it empty, we "swallow" the error so it isn't printed.
          }

      } catch {
          print "\n---"
          print "Exiting. Cleaning up 'myfifo'..."
          rm myfifo
          print "✅ Pipe removed."
      }
    '')
 

  ];


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
    #".local/bin/nulix-wezterm.nu" = {
    #  source = ./nulix-wezterm.nu;
    #  executable = true;
    #};
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
