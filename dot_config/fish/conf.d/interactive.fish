# Interactive-only setup (aliases, prompt, third-party integrations)
if status is-interactive

# File listing (eza)
alias ls='eza --icons=auto'
alias ll='eza --time-style="+%y-%m-%d %H:%M" --icons=auto -hla'
alias tree='eza --tree --git-ignore'

# Cat with syntax highlighting (bat)
alias cat='bat'
alias less='bat'

# Search (ripgrep)
alias grep='rg'

# System monitoring
alias top='btm'

# Disk usage
alias du='dust'
alias df='duf'

# Editor shortcut
alias e='$EDITOR'

~/.local/bin/mise activate fish | source
zoxide init fish | source
starship init fish | source
fish_config theme choose Dracula
end
