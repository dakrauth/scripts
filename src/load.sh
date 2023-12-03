shell=${SHELL##*/}
if [[ "$shell" = "bash" ]]; then
    root="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd -P )"
else
    #root="${(%):-%x}"
    root=$( cd "$( dirname "${(%):-%x}" )" 2>&1 && pwd -P )
fi

echo root=$root

for script in common python; do
    [[ $ECHO_ON = "1" ]] && echo Loading $root/${script}.sh
    source $root/${script}.sh
done

if [ $PLATFORM = "Darwin" ]; then
    [[ $ECHO_ON = "1" ]] && echo Loading $root/macos.sh
    source $root/macos.sh
elif [ $PLATFORM = "Linux" ]; then
    [[ $ECHO_ON = "1" ]] && echo Loading $root/linux.sh
    source $root/linux.sh
fi

for rc in .atlrc .privaterc; do
    if [ -e ~/$rc ]; then
        [[ $ECHO_ON = "1" ]] && echo Loading $rc
        source ~/$rc
    fi
done
