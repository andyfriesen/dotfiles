export CLICOLOR=1
export PS1=%~$\ 
alias grep='grep --color=auto'
export PATH=$PATH:/opt/local/bin:~/.cabal/bin
export LSCOLORS="ex"
export NINJA_STATUS="[%e %f/%t] "

setopt PROMPT_SUBST

#autoload -U compinit && compinit
#zstyle ':completion:*' menu select

autoload -U colors && colors

SSH_ENV="$HOME/.ssh/environment"
SCRIPT_SOURCE=${0:h}

function start_agent {
     echo "Initialising new SSH agent..."
     /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
     echo succeeded
     chmod 600 "${SSH_ENV}"
     . "${SSH_ENV}" > /dev/null
     /usr/bin/ssh-add;
}

function maybe_start_agent {
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
}

case $OSTYPE in
    (cygwin|msys)*)
        export PROMPT="%{$fg[green]%}%~%{$fg[yellow]%}%# %{$reset_color%}"
        export TERM=xterm-256color
        alias ls='ls --color'
        eval "$(dircolors -b $SCRIPT_SOURCE/dircolors.txt)"

	maybe_start_agent;
        ;;

    linux*)
        # Start ssh-agent on WSL
        (uname -a | grep Microsoft > /dev/null) && {
            maybe_start_agent;
        }

        export PROMPT="%{$fg[green]%}%~%{$fg[cyan]%}%# %{$reset_color%}"
        eval "$(dircolors $SCRIPT_SOURCE/dircolors.txt)"
        alias ls='ls --color'

	(uname -a | grep Microsoft > /dev/null) && maybe_start_agent;
        ;;

    darwin*)
        export PROMPT="%{$fg[green]%}%~%{$fg[yellow]%}%# %{$reset_color%}"
        export PATH=/opt/local/bin:$PATH
        if [ -d ~/Library/Haskell/bin ]; then
            export PATH=~/Library/Haskell/bin:$PATH
        fi
        ;;
esac

if [ -n "$SSH_CLIENT" ]; then
    export PROMPT="%{$fg[red]%}%m $PROMPT"
fi

function check_last_exit_code() {
  local LAST_EXIT_CODE=$?
  if [[ "$LAST_EXIT_CODE" -ne 0 ]]; then
    echo "%{$fg[red]%}-%{$fg_bold[red]%}$LAST_EXIT_CODE%{$reset_color%}%{$fg[red]%}-%{$reset_color%}"
  fi
}

export RPROMPT='$(check_last_exit_code)'

#autoload -U compinit
#compinit -C
#autoload -U zstyle+
#zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

setopt -o sharehistory

alias json-pretty="python -m json.tool"

export HISTSIZE=1000
export SAVEHIST=1000
export HISTFILE=~/.zshhistory
