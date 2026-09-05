# is-interactive, not is-login: the .bashrc handoff is a bare `exec fish`.
if status is-interactive; and test (tty) = "/dev/tty1"
    if type -q Hyprland
        exec Hyprland
    end
end
