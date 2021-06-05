import subprocess
from libqtile import widget

class KeyboardLayout(widget.KeyboardLayout):
    def __init__(self, colors):
        widget.KeyboardLayout.__init__(self,
            configured_keyboards=['es','us altgr-intl'], fmt = '')
        self.colors = colors
    def mouse_enter(self, x, y):
        self.foreground = self.colors['green']
        setattr(self, 'fmt', '  {}')
        #self.tick()
        self.draw()
        #self.update(self.poll())
    def mouse_leave(self, x, y):
        self.foreground = self.colors['main']
        setattr(self, 'fmt', '')
        #self.tick()
        self.draw()
        #self.update(self.poll())

