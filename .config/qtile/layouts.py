from libqtile import layout
from theme import colors

group_names = [("一", {'layout': 'monadtall'}),
               ("二", {'layout': 'monadtall'}),
               ("三", {'layout': 'monadtall'}),
               ("四", {'layout': 'monadtall'}),
               ("五", {'layout': 'monadtall'}),
               ("六", {'layout': 'monadtall'}),
               ("七", {'layout': 'monadtall'}),
               ("八", {'layout': 'monadtall'}),
               ("十", {'layout': 'monadtall'})]

layout_theme = {'border_width': 2,
                'margin': 6,
                'border_focus': colors['green'],
                'border_normal': colors['gray']
                }

layouts = [
    layout.MonadTall(**layout_theme),
    layout.Max(**layout_theme),
    #layout.Floating(**layout_theme),
    # layout.Stack(num_stacks=2),
    # Try more layouts by unleashing below layouts.
    # layout.Bsp(),
    # layout.Columns(**layout_theme),
    layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    {'wmclass': 'confirm'},
    {'wmclass': 'dialog'},
    {'wmclass': 'download'},
    {'wmclass': 'error'},
    {'wmclass': 'file_progress'},
    {'wmclass': 'notification'},
    {'wmclass': 'splash'},
    {'wmclass': 'toolbar'},
    {'wmclass': 'confirmreset'},  # gitk
    {'wmclass': 'makebranch'},  # gitk
    {'wmclass': 'maketag'},  # gitk
    {'wname': 'branchdialog'},  # gitk
    {'wname': 'pinentry'},  # GPG key password entry
    {'wmclass': 'ssh-askpass'},  # ssh-askpass
    {'wmclass': 'latte-dock'}
])


