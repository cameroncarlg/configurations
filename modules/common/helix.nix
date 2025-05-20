{ pkgs, ...}:

{
    programs.helix = {
    enable = true;
    defaultEditor = true;
    languages = {
      # the language-server option currently requires helix from the master branch at https://github.com/helix-editor/helix/
      # language-server.typescript-language-server = with pkgs.nodePackages; {
      #   command = "${typescript-language-server}/bin/typescript-language-server";
      #   args = [ "--stdio" "--tsserver-path=${typescript}/lib/node_modules/typescript/lib"];
      # };
      nix = {
        language-server = {
          command = "${pkgs.nil}/bin/nil";
          args = [ "--stdio" ];
        };
        formatter = {
          command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt";
          args = [ "--stdio "];
        };
      };
      language = [
        {
          name = "html";
          formatter = {
            command = "${pkgs.nodePackages.prettier}/bin/prettier";
            args = [ "--stdin-filepath" "{}" "--parser" "html" ];
          };
        }
        {
          name = "css";
          formatter = {
            command = "${pkgs.nodePackages.prettier}/bin/prettier";
            args = [ "--stdin-filepath" "{}" "--parser" "css" ];
          };
        }
        {
          name = "javascript";
          formatter = {
            command = "${pkgs.nodePackages.prettier}/bin/prettier";
            args = [ "--stdin-filepath" "{}" ];
          };
        }
        {
          name = "typescript";
          formatter = {
            command = "${pkgs.nodePackages.prettier}/bin/prettier";
            args = [ "--stdin-filepath" "{}" ];
          };
        }
        {
          name = "jsx";
          formatter = {
            command = "${pkgs.nodePackages.prettier}/bin/prettier";
            args = [ "--stdin-filepath" "{}" "--parser" "jsx" ];
          };
        }
        {
          name = "tsx";
          auto-format = true;
          # formatter = {
          #   command = "${pkgs.nodePackages.prettier}/bin/prettier";
          #   args = [ "--stdin-filepath" "{}" "--parser" "tsx" ];
          # };
        }
        {
          name = "json";
          auto-format = true;
          # formatter = {
          #   command = "${pkgs.nodePackages.prettier}/bin/prettier";
          #   args = [ "--stdin-filepath" "{}" "--parser" "json" ];
          # };
        }
      ];
    };
    settings = {
      theme = "catppuccin_mocha";
      editor = {
        line-number = "relative";
        lsp.display-messages = true;
        auto-format = true;
      };
      keys.normal = {
        esc = [ "collapse_selection" "keep_primary_selection" ];
      };
      keys.normal.";" = {
        b = ":sh helix-wezterm.sh blame";
        c = ":sh helix-wezterm.sh check";
        e = ":sh helix-wezterm.sh explorer";
        f = ":sh helix-wezterm.sh fzf";
        g = ":sh helix-wezterm.sh lazygit";
        o = ":sh helix-wezterm.sh open";
        r = ":sh helix-wezterm.sh run";
        s = ":sh helix-wezterm.sh test_single";
        t = ":sh helix-wezterm.sh test_all";
      };
    };
  };
}
