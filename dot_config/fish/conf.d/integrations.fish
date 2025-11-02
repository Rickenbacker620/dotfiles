# Third-party tool integrations
if status --is-interactive
    zoxide init fish | source
    ~/.local/bin/mise activate fish | source
end
