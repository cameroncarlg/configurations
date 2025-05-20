{
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
}
