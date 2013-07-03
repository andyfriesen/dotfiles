export CLICOLOR=1
export PS1=%~$\ 
alias grep='grep --color=auto'
export PATH=$PATH:/opt/local/bin:~/.cabal/bin
export LSCOLORS="ex"

autoload -U colors && colors

case $OSTYPE in
    linux*)
        export PS1="$fg[red]%m $fg[green]%~$fg[white]$ $reset_color"
        ;;

    darwin*)
        export PS1="$fg[green]%~$fg[yellow]$ $reset_color"
        alias sandbox='ssh -A cit@localhost.imvu.com'
        ;;
esac

#autoload -U compinit
#compinit -C
#autoload -U zstyle+
#zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

alias update='~/ntp && s/update'

export HISTSIZE=1000
export SAVEHIST=1000
export HISTFILE=~/.zshhistory
