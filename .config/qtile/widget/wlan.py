import subprocess
from libqtile import widget

class Wlan(widget.Wlan):
    def __init__(self, colors):
        widget.Wlan.__init__(self,
                interface='wlp3s0', format='')
        self.colors = colors
    def mouse_enter(self, x, y):
        self.foreground = self.colors['green']
        setattr(self, 'format', ' {essid} {percent:2.0%}')
        self.update(self.poll())
    def mouse_leave(self, x, y):
        self.foreground = self.colors['main']
        setattr(self,'format','')
        self.update(self.poll())

