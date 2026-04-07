import subprocess
from libqtile.widget import base

class ThemeSwitcher(base._TextBox):
    def __init__(self, **config):
        base._TextBox.__init__(self, "", **config)
        self.update_interval = 5
        self.add_callbacks({
            'Button1': self.toggle_theme
        })

    def get_current_mode(self):
        try:
            result = subprocess.run(
                ['darkman', 'get'],
                capture_output=True, text=True
            )
            if result.returncode == 0:
                return result.stdout.strip()
        except Exception:
            pass
        return "dark"

    def update_text(self):
        mode = self.get_current_mode()
        self.current_mode = mode
        self.text = "" if mode == "light" else ""
        self.bar.draw()

    def toggle_theme(self):
        new_mode = "light" if self.current_mode == "dark" else "dark"
        subprocess.run(['darkman', 'set', new_mode])
        self.current_mode = new_mode
        self.text = "" if new_mode == "light" else ""
        self.bar.draw()

    def timer_setup(self):
        # Aquí self.bar ya existe
        self.update_text()
        self.timeout_add(self.update_interval, self._refresh)

    def _refresh(self):
        self.update_text()
        self.timeout_add(self.update_interval, self._refresh)
