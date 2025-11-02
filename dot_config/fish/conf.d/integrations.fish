# Third-party tool integrations
if status --is-interactive
    ~/.local/bin/mise activate fish | source
    zoxide init fish | source
end
