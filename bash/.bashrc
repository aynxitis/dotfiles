#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
export PATH="$HOME/.local/bin:$PATH"

# kimi-code
export PATH="/home/anis/.kimi-code/bin:$PATH"


# Added by Antigravity CLI installer
export PATH="/home/anis/.local/bin:$PATH"
export PATH=~/.npm-global/bin:$PATH

# Github commits
alias updates='cd ~/Projects/updates && python3 streak.py'

# ssh-agent from the systemd user socket (ssh-agent.socket), unless a
# session already provides one.
[[ -z $SSH_AUTH_SOCK ]] && export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# Machine-local config (secrets, tokens). Gitignored, never stowed.
[[ -f ~/.bashrc.local ]] && . ~/.bashrc.local
