if [ -t 1 ]; then
    echo Using ssty sane
    stty sane
fi

shopt -s histappend
shopt -s checkwinsize
ulimit -n 2048
PROMPT_COMMAND='history -a'

export PLATFORM=$(uname)
export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:/usr/local/sbin:$PATH"

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

function loadflags() {
    export CPPFLAGS="-I/usr/local/opt/$1/include ${CPPFLAGS}"
    export LDFLAGS="-L/usr/local/opt/$1/lib ${LDFLAGS}"
    if [ $PKG_CONFIG_PATH ]; then
        export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:/usr/local/opt/$1/lib/pkgconfig"
    else
        export PKG_CONFIG_PATH="/usr/local/opt/$1/lib/pkgconfig"
    fi
}

function shelp() {
    less $SCRIPTS_PATH/README.md
}

function ssh_forward() {
    ssh -N $1 -L 8778:127.0.0.1:3306
}

function mcd() { 
    mkdir -p "$@" && cd "${1}" 
}

function mantext() {
    man "$1"  | col -bx
}

function calc() { 
    echo "${1}" | bc -l 
}

function md() {
    local fname
    for fname in "$@"; do
        echo "${fname} --> ${fname%.*}.html"
        markdown "$fname" > "${fname%.*}.html"
    done
}

function scsswatch() {
    echo Watching "${1}:${1%.*}.css"
    scss --watch "${1}:${1%.*}.css"
}

function swapext() {
    local ext="$1"
    shift
    for orig in "$@"
    do
        echo "$orig ==> " "${orig%.*}.${ext}"
        mv "$orig" "${orig%.*}.${ext}"
    done
}

function tbz () {
    tar cvjf "$1".tbz "$1"
}


function git_killtag () {
    git tag -d "$1" && git push --delete origin "$1"
}

function whatport() {
    lsof -i :$1
}

function loadnvm() {
    export NVM_DIR="$HOME/.nvm"

    echo Loading NVM shell...
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    echo Finished NVM shell

    echo Loading NVM bash completion...
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
    echo Finished NVM bash completion...
}

function showcolors() {
    # Escape code
    local esc=`echo -en "\033"`

    #   30  Black
    #   31  Red
    #   32  Green
    #   33  Yellow
    #   34  Blue
    #   35  Magenta
    #   36  Cyan
    #   37  White

    # Set colors
    local cc_normal=`echo -en "${esc}[m\017"`

    echo "${esc}[0;30mThis line is black.${cc_normal}"
    echo "${esc}[0;31mThis line is red.${cc_normal}"
    echo "${esc}[0;32mThis line is green.${cc_normal}"
    echo "${esc}[0;33mThis line is yellow.${cc_normal}"
    echo "${esc}[0;34mThis line is blue.${cc_normal}"
    echo "${esc}[0;35mThis line is magenta.${cc_normal}"
    echo "${esc}[0;36mThis line is cyan.${cc_normal}"
    echo "${esc}[0;37mThis line is white.${cc_normal}"

    echo "${esc}[1;30mThis line is bold black.${cc_normal}"
    echo "${esc}[1;31mThis line is bold red.${cc_normal}"
    echo "${esc}[1;32mThis line is bold green.${cc_normal}"
    echo "${esc}[1;33mThis line is bold yellow.${cc_normal}"
    echo "${esc}[1;34mThis line is bold blue.${cc_normal}"
    echo "${esc}[1;35mThis line is bold magenta.${cc_normal}"
    echo "${esc}[1;36mThis line is bold cyan.${cc_normal}"
    echo "${esc}[1;37mThis line is bold white.${cc_normal}"

}

function csv2json() {
    python <<EOF
import sys, csv, json
with open('$1') as ifp:
    print(json.dumps(list(csv.DictReader(ifp)), indent=4))
EOF
}

# see http://www-128.ibm.com/developerworks/linux/library/l-tip-prompt/
function configure_prompt() {
    local       FG_NORMAL="\[\e[0;m\]"
    local        FG_BLACK="\[\e[0;30m\]"
    local          FG_RED="\[\e[0;31m\]"
    local        FG_GREEN="\[\e[0;32m\]"
    local       FG_YELLOW="\[\e[0;33m\]"
    local         FG_BLUE="\[\e[0;34m\]"
    local      FG_MAGENTA="\[\e[0;35m\]"
    local         FG_CYAN="\[\e[0;36m\]"
    local        FG_WHITE="\[\e[0;37m\]"
    local     FG_BOLD_RED="\[\e[1;31m\]"
    local   FG_BOLD_GREEN="\[\e[1;32m\]"
    local  FG_BOLD_YELLOW="\[\e[1;33m\]"
    local    FG_BOLD_BLUE="\[\e[1;34m\]"
    local FG_BOLD_MAGENTA="\[\e[1;35m\]"
    local    FG_BOLD_CYAN="\[\e[1;36m\]"
    local   FG_BOLD_WHITE="\[\e[1;37m\]"

    local         BG_BLUE="\[\e[1;44m\]"
    local       BG_YELLOW="\[\e[1;43m\]"

    export PS1=${FG_BOLD_WHITE}${BG_YELLOW}'$(__git_ps1 "<%s>")'${BG_BLUE}${FG_BOLD_WHITE}'[\w]'$FG_BLUE'\$ '$FG_NORMAL
    export PS2='> '
    export PS4='+ '
}

alias utcnow='python -c "import datetime;print(datetime.datetime.utcnow())"'
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
alias reload='source ~/.bashrc'

# directory tree - http://www.shell-fu.org/lister.php?id=209  
alias dtree='find . -type d | sed -e "s/[^-][^\/]*\//  |/g" -e "s/|\([^ ]\)/|-\1/"'  

source /usr/local/etc/bash_completion.d/git-completion.bash
source /usr/local/etc/bash_completion.d/git-prompt.sh
configure_prompt
