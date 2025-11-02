# Third-party tool integrations
if status --is-interactive
    ~/.local/share/mise/shims/zoxide init fish | source
    ~/.local/bin/mise activate fish | source
end
