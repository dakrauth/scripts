export SCRIPTS_SRC="${HOME}/scripts/src"

if [[ -n "$BASH_VERSINFO" ]]; then
    export CURR_SHELL="bash"
fi
if [[ -n "$ZSH_VERSION" ]]; then
    export CURR_SHELL="zsh"
fi

for script in common python; do
    [[ $ECHO_ON = "1" ]] && echo Loading $HOME/${script}.sh
    source "$SCRIPTS_SRC/${script}.sh"
done

if [ $PLATFORM = "Darwin" ]; then
    [[ $ECHO_ON = "1" ]] && echo Loading "$SCRIPTS_SRC/macos.sh"
    source "$SCRIPTS_SRC/macos.sh"
elif [ $PLATFORM = "Linux" ]; then
    [[ $ECHO_ON = "1" ]] && echo Loading $HOME/linux.sh
    source "$SCRIPTS_SRC/linux.sh"
fi

if [ -e ~/.privaterc ]; then
    [[ $ECHO_ON = "1" ]] && echo Loading .privaterc
    source ~/.privaterc
fi
