alias l 'eza -la --icons=auto'
alias ls 'eza -a --icons=auto'
alias vim nvim

starship init fish | source
fzf --fish | source

if status is-interactive
    mise activate fish | source
end
