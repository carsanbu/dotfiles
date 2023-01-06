from libqtile.log_utils import logger
def show_keys(keys):
    """
  print current keybindings in a pretty way for a rofi/dmenu window.
  """
    key_help = "{:<20} {:<30} \n".format('Keybinds', 'Description')
    keys_ignored = (
        "XF86AudioMute",  #
        "XF86AudioLowerVolume",  #
        "XF86AudioRaiseVolume",  #
        "XF86AudioPlay",  #
        "XF86AudioNext",  #
        "XF86AudioPrev",  #
        "XF86AudioStop",
        "XF86MonBrightnessUp",
        "XF86MonBrightnessDown",
    )
    text_replaced = {
        "mod4": "[MOD]",  #
        "control": "[CTRL]",  #
        "mod1": "[ALT]",  #
        "shift": "[SHIFT]",  #
        "Escape": "ESC",  #
    }
    for k in keys:
        if k.key in keys_ignored:
            continue

        mods = ""
        key = ""
        desc = k.desc.title()
        for m in k.modifiers:
            if m in text_replaced.keys():
                mods += text_replaced[m] + " + "
            else:
                mods += m.capitalize() + " + "

        if len(k.key) > 1:
            if k.key in text_replaced.keys():
                key = text_replaced[k.key]
            else:
                key = k.key.title()
        else:
            key = k.key

        key_line = "{:<30} {}\n".format(mods + key, desc)
        key_help += key_line

    return key_help
