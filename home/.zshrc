# If you come from bash you might have to change your $PATH.

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export DEFAULT_USER=$USER

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
SOLARIZED_THEME="light"
ZSH_THEME="agnoster"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(dirhistory)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias ohmyzsh="mate ~/.oh-my-zsh"
export EDITOR='/usr/local/bin/subl -w'

alias z.ed="subl ~/.zshrc"
alias z.ld=". ~/.zshrc"
alias ll='ls -alFG'
alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"

unalias run-help 2>/dev/null
autoload run-help
alias help='run-help'
alias ppath='echo -e ${PATH//:/\\n}'

export BAT_THEME=OneHalfLight

gitfzf () {
    git log \
        --color=always \
        --format="%C(cyan)%h %C(blue)%ar%C(auto)%d \
                  %C(yellow)%s%+b %C(black)%ae" "$@" |
    fzf -i -e +s \
        --reverse \
        --tiebreak=index \
        --no-multi \
        --ansi \
        --preview="echo {} |
                   grep -o '[a-f0-9]\{7\}' |
                   head -1 |
                   xargs -I % sh -c 'git show --color=always % |
                   diff-so-fancy'" \
        --header "enter: view, C-c: copy hash" \
        --bind "enter:execute:$_viewGitLogLine | less -R" \
        --bind "ctrl-c:execute:$_gitLogLineToHash |
                xclip -r -selection clipboard" 
}


export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

eval "$(pyenv init -)"
source $HOME/scripts/src/load.sh

export VW_HOME=$HOME/dev/venvs
export NF_HOME=/www/nerdfog.com
source $HOME/dev/yavw/vw.sh
source $HOME/bin/dbutils
source $HOME/dev/www/nerdfog.com/aliases.sh
source $HOME/.secrets

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias myip="curl http://ipecho.net/plain; echo"

function sshkx() {
    if [[ "$1" = "" ]]; then
        echo Please provide the start of the host name or IP
    else
        rm -f ~/.ssh/known_hosts.old
        mv ~/.ssh/known_hosts ~/.ssh/known_hosts.old
        grep -v "^${1}" ~/.ssh/known_hosts.old > ~/.ssh/known_hosts
    fi
}

echo curl -s "wttr.in/{Honolulu,Seoul}?format=3"
vw home
alias vnd="cd ~/dev/vnd"
alias www="cd ~/dev/www"
alias nf="cd ~/dev/www/nerdfog.com"

function mvcode() {
    mv "$1" ~/Documents/dev/code
}

favtz() {
    # Honolulu Paris NYC
    ~/dev/when/.dev/venv/bin/when \
    --source 5856195 \
    --source 2988507 \
    --source 5128581
}

favtz
