import subprocess
from libqtile import widget

class Battery(widget.Battery):
    def __init__(self, colors):
        widget.Battery.__init__(self,
            energy_now_file='charge_now',
            energy_full_file='charge_full',
            power_now_file='current_now',
            charge_char='',
            discharge_char='',
            empty_char = '',
            full_char = '',
            unknown_char = '',
            format='{char}  {percent:2.0%} ({hour:d}:{min:02d})',
            mouse_callbacks={'Button1': self.open_powertop}
            )
        self.colors = colors
    def open_powertop(self):
        subprocess.run('alacritty -e sudo powertop &', shell=True)

