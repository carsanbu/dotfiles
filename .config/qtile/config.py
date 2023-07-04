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
from libqtile.config import Click, Drag, Group, Key, Screen, Match
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from layouts import layouts, floating_layout, group_names
from theme import colors
from widget.battery import Battery
#from widget.wlan import Wlan
#from widget.keyboard_layout import KeyboardLayout
from show_keys import show_keys

def bt_status():
   return subprocess.getoutput('/home/carlos/.local/bin/system-bluetooth-bluetoothctl.sh')
def bt_mouse_click(qtile):
    subprocess.run(['/home/carlos/.local/bin/system-bluetooth-bluetoothctl.sh', '--toggle'])
def notification_toggle():
    subprocess.run(['/home/carlos/.local/bin/notification-center-toggle.sh'])

if __name__ in ["config", "__main__"]:
    # key macros
    ALT = 'mod1'
    WIN = 'mod4'
    TAB = 'Tab'
    CTRL = 'control'
    SHIFT = 'shift'
    RETURN = 'Return'
    SPACE = 'space'

    mod = WIN
    terminal = 'alacritty'

    keys = [
        # Resize windows
        Key([mod, SHIFT], "i", lazy.layout.grow(),
            desc='Grow window'),
        Key([mod, SHIFT], "m", lazy.layout.shrink(),
            desc='Shrink window'),
        Key([mod, SHIFT], "n", lazy.layout.normalize(),
            desc='Normalize window'),

        # Move windows up or down in current stack
        Key([mod, CTRL], "k", lazy.layout.shuffle_down(),
            desc="Move window down in current stack "),
        Key([mod, CTRL], "j", lazy.layout.shuffle_up(),
            desc="Move window up in current stack "),

        # Switch window focus to other pane(s) of stack
        Key([ALT], TAB, lazy.layout.next(),
            desc="Switch window focus to other pane(s) of stack"),

        # Swap panes of split stack
        Key([mod, SHIFT], "space", lazy.layout.rotate(),
            desc="Swap panes of split stack"),
        Key([mod], 'f', lazy.window.toggle_fullscreen(), desc='Toggle fullscreen mode'),
        # Toggle between split and unsplit sides of stack.
        # Split = all windows displayed
        # Unsplit = 1 window displayed, like Max layout, but still with
        # multiple stack panes
        Key([mod, SHIFT], "Return", lazy.layout.toggle_split(),
            desc="Toggle between split and unsplit sides of stack"),
        Key([mod], RETURN, lazy.spawn(terminal), desc="Launch terminal"),

        # Toggle between different layouts as defined below
        Key([mod], TAB, lazy.next_layout(), desc="Toggle between layouts"),
        Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),

        Key([mod, CTRL], "r", lazy.restart(), desc="Restart qtile"),
        Key([mod, CTRL], "q", lazy.shutdown(), desc="Shutdown qtile"),
        Key([mod], "r", lazy.spawn(os.path.expanduser('~/.local/bin/launcher.sh'))),
        Key([mod], "b", lazy.spawn('firefox')),
        Key([mod], "e", lazy.spawn([terminal, '-e', 'ranger'])),

        # Sound
        Key([], "XF86AudioMute", lazy.spawn("amixer -q set Master toggle")),
        Key([], "XF86AudioLowerVolume", lazy.spawn("amixer -c 0 sset Master 1- unmute")),
        Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer -c 0 sset Master 1+ unmute")),
        # Power off
        Key([], 'XF86PowerOff', lazy.spawn(os.path.expanduser(
            '~/.local/bin/launcher-poweroff.sh'))),
        Key([mod], 'q', lazy.spawn(os.path.expanduser(
            '~/.local/bin/launcher-poweroff.sh'))),
        Key([mod], 'l', lazy.spawn('multilockscreen --lock blur'), desc='Bloquea el escritorio'),
        Key([mod], 'v', lazy.spawn(os.path.expanduser('~/.local/bin/launcher-clipboard.sh')), desc='Historial del clipboard'),
        Key([mod, SHIFT], 'e', lazy.spawn(os.path.expanduser('~/.local/bin/launcher-emoji.sh')), desc='Selector de emoji'),
        Key([mod, SHIFT], 'b', lazy.spawn(os.path.expanduser('~/.local/bin/launcher-bluetooth.sh')), desc='Selector de emoji')
    ]

    groups = [Group(name, **kwargs) for name, kwargs in group_names]

    for i, (name, kwargs) in enumerate(group_names, 1):
        keys.append(Key([mod], str(i), lazy.group[name].toscreen()))        # Switch to another group
        keys.append(Key([mod, "shift"], str(i), lazy.window.togroup(name))) # Send current window to another group
    # Group 9 is for services
    groups[8].matches = [
        Match(wm_class=['Syncthing GTK']),
        Match(wm_class=['KeePassXC'])
    ]

    widget_defaults = dict(
        font='CodeNewRoman Nerd Font',
        fontsize=18,
        padding=8,
        foreground=colors['main'],
    )

    extension_defaults = widget_defaults.copy()
    w1 = [
            widget.WindowName(),
            widget.GroupBox(
                active=colors['green'],
                this_current_screen_border=colors['green'],
                this_screen_border=colors['green'],
                other_screen_border=colors['gray'],
                highlight_method='line',
                disable_drag=True),
            widget.Chord(
                chords_colors={ 'launch': ("#ff0000", "#ffffff") },
                name_transform=lambda name: name.upper(),
            ),
            widget.CurrentLayoutIcon(scale=0.6),
            widget.Spacer(),
            widget.StatusNotifier(),
            widget.GenPollText(func=bt_status, update_interval=5,
                mouse_callbacks={'Button1': bt_mouse_click},
            ),
            widget.Volume(fmt=' {}'),
            widget.Clock(format=' %H:%M'),
            widget.TextBox(text = '', mouse_callbacks={'Button1': notification_toggle}),
        ]
    if os.path.isdir("/sys/module/battery"):
        w1.insert(6, Battery(colors))

    w2 = [
            widget.WindowName(),
            widget.GroupBox(
                active=colors['green'],
                this_current_screen_border=colors['green'],
                this_screen_border=colors['green'],
                other_screen_border=colors['gray'],
                highlight_method='line'),
            widget.Chord(
                chords_colors={ 'launch': ("#ff0000", "#ffffff") },
                name_transform=lambda name: name.upper(),
            ),
            widget.CurrentLayoutIcon(scale=0.6),
            widget.Spacer(),
            widget.StatusNotifier(),
            #Wlan(colors),
            Battery(colors),
            widget.GenPollText(func=bt_status, update_interval=5,
                mouse_callbacks={'Button1': bt_mouse_click},
            ),
            widget.Volume(fmt=' {}'),
            widget.Clock(format='  %H:%M'),
            widget.TextBox(text = '', mouse_callbacks={'Button1': notification_toggle}),
        ]

    screens = [
        Screen(top=bar.Bar(w1, 28, background='#000000f0', opacity=0.7)),
        #Screen(top=bar.Bar(w2, 28, background='#000000', opacity=0.7))
    ]

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
    auto_minimize = False

    # Needed for some Java programs
    wmname = "LG3D"

    # this must be done AFTER all the keys have been defined
    cheater = terminal + " --class='Cheater' -e sh -c 'echo \"" + show_keys(
        keys
    ) + "\" | fzf --prompt=\"Search for a keybind: \" --border=rounded --margin=1% --color=dark --height 100% --reverse --header=\"       QTILE CHEAT SHEET \" --info=hidden --header-first'"
    keys.extend([
        Key([WIN], "F1", lazy.spawn(cheater), desc="Print keyboard bindings"),
    ])

@hook.subscribe.startup
def autostart():
    autostart = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.call([autostart])

@hook.subscribe.screen_change
def restart_on_randr(qtile, ev):
    '''Restart on screen change'''
    qtile.cmd_restart()

