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
        { key = 'Enter', mods = 'ALT', action = wezterm.action.SplitHorizontal {domain = 'CurrentPaneDomain' }},
        { key = 'Enter', mods = 'ALT|SHIFT', action = wezterm.action.SplitVertical {domain = 'CurrentPaneDomain' }},
        { key = 't', mods = 'ALT|SHIFT', action = wezterm.action.ActivateTabRelative(-1) },
        { key = 'w', mods = 'ALT', action = wezterm.action.CloseCurrentPane {confirm = true }},
        { key = 'w', mods = 'ALT|SHIFT', action = wezterm.action.CloseCurrentTab {confirm = true }},
        { key = 'j', mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Next' },
        { key = 'k', mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Prev' },
        { key = 'h', mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Left' },
        { key = 'l', mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Right' },
        { key = 'h', mods = 'ALT|SHIFT', action = wezterm.action.AdjustPaneSize { 'Left', 5 }},
        { key = 'j', mods = 'ALT|SHIFT', action = wezterm.action.AdjustPaneSize { 'Down', 5 }},
        { key = 'k', mods = 'ALT|SHIFT', action = wezterm.action.AdjustPaneSize { 'Up', 5 }},
        { key = 'l', mods = 'ALT|SHIFT', action = wezterm.action.AdjustPaneSize { 'Right', 5 }},
        { key = 'n', mods = 'ALT', action = wezterm.action.TogglePaneZoomState },
        { key = 'p', mods = 'ALT|SHIFT', action = wezterm.action.ToggleFullScreen },
      }
      return config
    '';
  };
}
