# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="half-life"

ENABLE_CORRECTION="true"

plugins=( 
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

export PATH="$HOME/.local/bin":$PATH

alias vim='nvim'
alias v='nvim .'
alias cl='clear'
alias gw='cd ~/workspace'
alias gc='cd ~/.config'
alias f='fd --type d $FD_OPTIONS | fzf | xargs lvim'


alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias ls='ls -Av --group-directories-first --color=auto'
alias l='ls -lApthvr --group-directories-first --color=auto'

export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

# Display Pokemon-colorscripts
# Project page: https://gitlab.com/phoneybadger/pokemon-colorscripts#on-other-distros-and-macos
pokemon-colorscripts --no-title -s -r

