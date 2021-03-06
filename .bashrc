[[ $- == *i* ]] || return  # non-interactive shell

HISTCONTROL=ignoreboth
HISTSIZE=1000000000
HISTFILESIZE=1000000000
HISTFILE="$HOME"/.bash_history

shopt -s histappend
shopt -s checkwinsize
shopt -s globstar

if command -v lesspipe &>/dev/null; then
  export LESSOPEN="| /usr/bin/env lesspipe %s 2>&-"
fi

alias diff='diff --color=auto'
alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}'
alias clang-format='clang-format -style=file'
alias ls='ls --color=auto --group-directories-first'
alias tree='tree -aC -I .git --dirsfirst'
alias gedit='gedit &>/dev/null'

alias x='xclip -selection clipboard -in'          # cut to clipboard
alias v='xclip -selection clipboard -out'         # paste from clipboard
alias c='xclip -selection clipboard -in -filter'  # copy clipboard

if [[ -f /usr/share/bash-completion/bash_completion ]]; then
  source /usr/share/bash-completion/bash_completion
elif [[ -f /etc/bash_completion ]]; then
  source /etc/bash_completion
fi

if [[ -d ~/gitstatus ]]; then
  GITSTATUS_LOG_LEVEL=DEBUG
  source ~/gitstatus/gitstatus.prompt.sh
else
  PS1='\[\033[01;32m\]\u@\h\[\033[00m\] '           # green user@host
  PS1+='\[\033[01;34m\]\w\[\033[00m\]'              # blue current working directory
  PS1+='\n\[\033[01;$((31+!$?))m\]\$\[\033[00m\] '  # green/red (success/error) $/# (normal/root)
  PS1+='\[\e]0;\u@\h: \w\a\]'                       # terminal title: user@host: dir
fi
