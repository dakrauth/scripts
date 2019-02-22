# see http://www-128.ibm.com/developerworks/linux/library/l-tip-prompt/
function configure_prompt
{
    local         NORMAL="\[\e[0;m\]"
    local          BLACK="\[\e[0;30m\]"
    local            RED="\[\e[0;31m\]"
    local     BRIGHT_RED="\[\e[1;31m\]"
    local          GREEN="\[\e[0;32m\]"
    local   BRIGHT_GREEN="\[\e[1;32m\]"
    local         YELLOW="\[\e[0;33m\]"
    local  BRIGHT_YELLOW="\[\e[1;33m\]"
    local           BLUE="\[\e[0;34m\]"
    local    BRIGHT_BLUE="\[\e[1;34m\]"
    local        MAGENTA="\[\e[0;35m\]"
    local BRIGHT_MAGENTA="\[\e[1;35m\]"
    local           CYAN="\[\e[0;36m\]"
    local    BRIGHT_CYAN="\[\e[1;36m\]"
    local          WHITE="\[\e[0;37m\]"
    local   BRIGHT_WHITE="\[\e[1;37m\]"
    export PS1=$BLUE'[\w]'$YELLOW'$(__git_ps1 " (%s)")'$BLUE'\$ '$NORMAL
    export PS2='> '
    export PS4='+ '
}

#source /usr/local/git/contrib/completion/git-completion.bash
source /usr/local/etc/bash_completion.d/git-completion.bash
source /usr/local/etc/bash_completion.d/git-prompt.sh
configure_prompt

export PATH="$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH"

# Eternal bash history.
# ---------------------
# Undocumented feature which sets the size to "unlimited".
# http://stackoverflow.com/questions/9457233/unlimited-bash-history
export HISTCONTROL=ignoredups
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE=~/.bash_eternal_history

export COPYFILE_DISABLE=true
export EDITOR="/usr/local/bin/subl -w"
export VISUAL="$EDITOR"

export CFLAGS="-Wno-error=varargs"

alias ll='ls -alFG'
alias h='history'
alias ..='cd ..'
alias grep='egrep'
alias ports='sudo lsof -i -P'
alias path='echo -e ${PATH//:/\\n}'
alias rsyncx='rsync -az -e ssh --progress'
alias getitall='wget --mirror --convert-links'
alias hgrep='history | grep'
alias dux='du -ks ./* | sort -nr'
alias dc='docker-compose'


# directory tree - http://www.shell-fu.org/lister.php?id=209  
alias dtree='find . -type d | sed -e "s/[^-][^\/]*\//  |/g" -e "s/|\([^ ]\)/|-\1/"'  
