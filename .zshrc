export CLICOLOR=1
export PS1=%~$\ 
alias grep='grep --color=auto'
export PATH=$PATH:/opt/local/bin:~/.cabal/bin
export LSCOLORS="ex"

autoload -U colors && colors

SSH_ENV="$HOME/.ssh/environment"
SCRIPT_SOURCE=${$(readlink -f ~/.zshrc):h}

function start_agent {
     echo "Initialising new SSH agent..."
     /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
     echo succeeded
     chmod 600 "${SSH_ENV}"
     . "${SSH_ENV}" > /dev/null
     /usr/bin/ssh-add;
}

case $OSTYPE in
    cygwin*)
        export PROMPT="%{$fg[green]%}%~%{$fg[yellow]%}%# %{$reset_color%}"
        export TERM=xterm-256color

        # Source SSH settings, if applicable
        if [ -f "${SSH_ENV}" ]; then
             . "${SSH_ENV}" > /dev/null
             #ps ${SSH_AGENT_PID} doesn't work under cywgin
             ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
                 start_agent;
             }
        else
             start_agent;
        fi

        ;;

    linux*)
        export PROMPT="%{$fg[red]%}%m %{$fg[green]%}%~%{$fg[cyan]%}%# %{$reset_color%}"
        eval "$(dircolors $SCRIPT_SOURCE/dircolors.txt)"
        alias ls='ls --color'
        ;;

    darwin*)
        export PROMPT="%{$fg[green]%}%~%{$fg[yellow]%}%# %{$reset_color%}"
        export PATH=/opt/local/bin:$PATH
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
