scripts_src="${HOME}/scripts/etc"

if [[ -n "$BASH_VERSINFO" ]]; then
    export CURR_SHELL="bash"
fi
if [[ -n "$ZSH_VERSION" ]]; then
    export CURR_SHELL="zsh"
fi

for script in common python; do
    source "$scripts_src/${script}.sh"
done

if [ $PLATFORM = "Darwin" ]; then
    source "$scripts_src/macos.sh"
elif [ $PLATFORM = "Linux" ]; then
    source "$scripts_src/linux.sh"
fi

if [ -e ~/.privaterc ]; then
    [[ $ECHO_ON = "1" ]] && echo Loading .privaterc
    source ~/.privaterc
fi
