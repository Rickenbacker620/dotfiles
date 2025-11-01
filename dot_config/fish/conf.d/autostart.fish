# Autostart Hyprland on TTY1
if test (tty) = "/dev/tty1"
    if type -q Hyprland
        exec Hyprland
    end
end
