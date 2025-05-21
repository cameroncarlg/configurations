{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    shellAbbrs = {
      sw = "sudo nixos-rebuild switch";
      wthr = "wthrr -u f,12h,in";
      nf = "fastfetch";
      cat = "bat";
      ld = "lazydocker";
      lg = "lazygit";
      # ll = "br -sdp";
    };
    functions = {
      # trash = "mv $argv[1] $HOME/.Trash";
      hxc = "sudo hx /etc/nixos/home.nix";
      hxcv = "sudo hx /etc/nixos/configuration.nix";
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
}
