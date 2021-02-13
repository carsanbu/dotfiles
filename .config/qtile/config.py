# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import os
import subprocess
from typing import List  # noqa: F401
from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from layouts import layouts, floating_layout, group_names
from theme import colors
from widget.battery import Battery

# key macros
ALT = 'mod1'
WIN = 'mod4'
TAB = 'Tab'
CTRL = 'control'
SHIFT = 'shift'
RETURN = 'Return'
SPACE = 'space'
MODKEY = ALT

mod = WIN
terminal = "alacritty" # guess_terminal()

keys = [
    # Switch between windows in current stack pane
    Key([mod], "k", lazy.layout.down(),
        desc="Move focus down in stack pane"),
    Key([mod], "j", lazy.layout.up(),
        desc="Move focus up in stack pane"),

    # Move windows up or down in current stack
    Key([mod, "control"], "k", lazy.layout.shuffle_down(),
        desc="Move window down in current stack "),
    Key([mod, "control"], "j", lazy.layout.shuffle_up(),
        desc="Move window up in current stack "),

    # Switch window focus to other pane(s) of stack
    Key([mod], TAB, lazy.layout.next(),
        desc="Switch window focus to other pane(s) of stack"),

    # Swap panes of split stack
    Key([mod, "shift"], "space", lazy.layout.rotate(),
        desc="Swap panes of split stack"),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return", lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack"),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),

    # Toggle between different layouts as defined below
    Key([mod], SPACE, lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),

    Key([mod, "control"], "r", lazy.restart(), desc="Restart qtile"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown qtile"),
    Key([mod], "r", lazy.spawn(os.path.expanduser('~/.local/bin/launcher.sh'))),
    # Sound
    Key([], "XF86AudioMute", lazy.spawn("amixer -q set Master toggle")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("amixer -c 0 sset Master 1- unmute")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer -c 0 sset Master 1+ unmute"))
]

groups = [Group(name, **kwargs) for name, kwargs in group_names]

for i, (name, kwargs) in enumerate(group_names, 1):
    keys.append(Key([mod], str(i), lazy.group[name].toscreen()))        # Switch to another group
    keys.append(Key([mod, "shift"], str(i), lazy.window.togroup(name))) # Send current window to another group

# Pasar a módulo theme.py
main_color = '9cff4d'
yellow = 'f3e500'
gray = '1D2330'
#

widget_defaults = dict(
    font='CodeNewRoman Nerd Font Complete',
    fontsize=14,
    padding=8,
    foreground=colors['main'],
)

def bt_status():
   return subprocess.getoutput('/home/carlos/.local/bin/system-bluetooth-bluetoothctl.sh')
def bt_mouse_click(qtile):
    subprocess.run(['/home/carlos/.local/bin/system-bluetooth-bluetoothctl.sh', '--toggle'])
def notification_toggle():
    subprocess.run(['/home/carlos/.local/bin/notification-center-toggle.sh'])

extension_defaults = widget_defaults.copy()
w1 = [
        widget.WindowName(),
        widget.GroupBox(
            active=main_color,
            this_current_screen_border=main_color,
            this_screen_border=main_color,
            other_screen_border=gray,
            highlight_method='line'),
        widget.Chord(
            chords_colors={ 'launch': ("#ff0000", "#ffffff") },
            name_transform=lambda name: name.upper(),
        ),
        widget.CurrentLayoutIcon(scale=0.6),
        widget.Spacer(),
        widget.Systray(),
        widget.Wlan(interface='wlp3s0', format=' {essid} {percent:2.0%}'),
        Battery(colors),
        #widget.KeyboardLayout(configured_keyboards=['es','us','us altgr-intl'], fmt = ' {}'),
        widget.GenPollText(func=bt_status, update_interval=5,
            mouse_callbacks={'Button1': bt_mouse_click},
        ),
        widget.TextBox(text = ' ', padding = 0),
        widget.Volume(padding = 5),
        widget.Clock(format=' %H:%M'),
        widget.TextBox(text = '', mouse_callbacks={'Button1': notification_toggle}),
    ]
w2 = [
        widget.WindowName(),
        widget.GroupBox(
            active=main_color,
            this_current_screen_border=main_color,
            this_screen_border=main_color,
            other_screen_border=gray,
            highlight_method='line'),
        widget.Chord(
            chords_colors={ 'launch': ("#ff0000", "#ffffff") },
            name_transform=lambda name: name.upper(),
        ),
        widget.CurrentLayoutIcon(scale=0.6),
        widget.Spacer(),
        widget.Systray(),
        widget.Wlan(interface='wlp3s0', format=' {essid} {percent:2.0%}'),
        Battery(colors),
        widget.KeyboardLayout(configured_keyboards=['es','us','us altgr-intl'], fmt = '  {}'),
        widget.GenPollText(func=bt_status, update_interval=5,
            mouse_callbacks={'Button1': bt_mouse_click},
        ),
        widget.TextBox(text = ' ', padding = 0),
        widget.Volume(padding = 5),
        widget.Clock(format='  %H:%M'),
        widget.TextBox(text = '', mouse_callbacks={'Button1': notification_toggle}),
    ]

screens = [
    Screen(top=bar.Bar(w1, 28, background='#000000', opacity=0.8)),
    Screen(top=bar.Bar(w2, 28, background='#000000', opacity=0.8))
]


@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.config/qtile/autostart.sh')
    log = os.path.expanduser('~/.local/share/qtile/autostart.log')
    with open(log, 'w') as logfile:
        subprocess.run(home, stdout=logfile)

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None  # WARNING: this is deprecated and will be removed soon
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = "smart"

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
