export CLICOLOR=1
export PS1=%~$\ 
alias grep='grep --color=auto'
export PATH=$PATH:/opt/local/bin:~/.cabal/bin
export LSCOLORS="ex"

fg_black="$(echo -n '\e[1;30m')"
fg_red="$(echo -n '\e[0;31m')"
fg_green="$(echo -n '\e[0;32m')"
fg_yellow="$(echo -n '\e[0;38m')"
fg_blue="$(echo -n '\e[0;34m')"
fg_magenta="$(echo -n '\e[0;35m')"
fg_cyan="$(echo -n '\e[1;36m')"
fg_white="$(echo -n '\e[0;38m')"

fg_brown="$(echo -n '\e[0;33m')"
fg_gray="$(echo -n '\e[0;37m')"

#export PS1="%{$fg_green%}%~%{$fg_cyan%}$ %{$fg_white%}"
export PS1="%{$fg_red%}%m %{$fg_green%}%~%{$fg_cyan%}$ %{$fg_white%}"

#autoload -U compinit
#compinit -C
#autoload -U zstyle+
#zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

alias update='~/ntp && s/update'
