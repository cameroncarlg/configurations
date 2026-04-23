{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    mouse = true;
    terminal = "tmux-256color";
    historyLimit = 50000;
    escapeTime = 10;
    keyMode = "vi";
    baseIndex = 1;
    extraConfig = ''
      # Friendlier splits: keep CWD
      bind '"' split-window -v -c "#{pane_current_path}"
      bind %   split-window -h -c "#{pane_current_path}"
      bind c   new-window   -c "#{pane_current_path}"

      # Reload config
      bind r source-file ~/.config/tmux/tmux.conf \; display "tmux.conf reloaded"

      # Passthrough for true-color + italics
      set -ga terminal-overrides ",*256col*:Tc"
    '';
  };

  # Auto-attach (or create) a tmux session named "main" when we land on this
  # host via Mosh, so reconnecting from the Moshi iOS client drops us right
  # back into the same workspace. We detect Mosh by walking the process tree
  # looking for a `mosh-server` ancestor (Mosh does not set a reliable env
  # var of its own). Skipped if already inside tmux, or if MOSH_NO_AUTOTMUX=1.
  programs.fish.interactiveShellInit = pkgs.lib.mkAfter ''
    function __in_mosh_session
      set -l pid $fish_pid
      while test -n "$pid"; and test "$pid" -gt 1
        set -l comm (command ps -o comm= -p $pid 2>/dev/null | string trim)
        if test "$comm" = mosh-server
          return 0
        end
        set pid (command ps -o ppid= -p $pid 2>/dev/null | string trim)
      end
      return 1
    end

    if status is-interactive
      and not set -q TMUX
      and not set -q MOSH_NO_AUTOTMUX
      and __in_mosh_session
        exec ${pkgs.tmux}/bin/tmux new-session -A -s main
    end
  '';
}
