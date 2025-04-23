#set -ex
echo SHELL = $SHELL
echo \$0 = $0
#export ECHO_ON=1
[[ $ECHO_ON = "1" ]] && echo Starting ~/.bashrc
source /usr/local/etc/bash_completion.d/git-prompt.sh
source "~/scripts/load.sh"
[[ $ECHO_ON = "1" ]] && echo .bashrc loaded
export PS1='\w$(__git_ps1 " (%s)")\$ '
