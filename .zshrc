# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git z)

source $ZSH/oh-my-zsh.sh

export LDFLAGS=/usr/local/opt/openblas/lib
export CPPFLAGS=/usr/local/opt/openblas/include
#export LD_LIBRARY_PATH='/home/rzn941/cudnn4/lib64':$LD_LIBRARY_PATH
#export CPATH='/home/rzn941/cudnn4/include':$CPATH
#export LIBRARY_PATH='/home/rzn941/cudnn4/lib64':$LD_LIBRARY_PATH

export TERM="xterm-256color"
alias mem="free -g | awk '/Mem:/{print $2}'"
alias gitdiff='git diff --color | diff-so-fancy'
export EDITOR=vim
#alias mvim='/Applications/MacVim.app/Contents/bin/mvim'

# for fun
alias ptt="ssh bbsu@ptt.cc"
# showing that you are using screen or not
if [ -n "$STY" ]; then export PS1="($STY) $PS1"; fi

alias dps="docker ps"
dex() {
    docker exec -it "$1" bash
}
