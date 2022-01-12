local wezterm = require 'wezterm';

return {
  color_scheme="Gruvbox Dark",
  send_composed_key_when_left_alt_is_pressed=false,
  send_composed_key_when_right_alt_is_pressed=false,
  exit_behavior = "Close",
  font = wezterm.font("Hasklug Nerd Font"),
  keys = {
    {key="C", mods="SHIFT|CTRL", action=wezterm.action{CopyTo='Clipboard'}},
    {key="V", mods="SHIFT|CTRL", action=wezterm.action{PasteFrom='Clipboard'}},
    {key="[", mods="ALT", action=wezterm.action{ActivateTabRelative=-1}},
    {key="]", mods="ALT", action=wezterm.action{ActivateTabRelative=1}},
    {key="{", mods="SHIFT|ALT", action=wezterm.action{MoveTabRelative=-1}},
    {key="}", mods="SHIFT|ALT", action=wezterm.action{MoveTabRelative=1}},
    {key="-", mods="CTRL", action="DecreaseFontSize"},
    {key="+", mods="CTRL", action="IncreaseFontSize"},
    {key="t", mods="SHIFT|ALT", action=wezterm.action{SpawnTab="CurrentPaneDomain"}},
  }
}
