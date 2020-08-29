#!/bin/bash
export SCRIPTS_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd -P )"
source $SCRIPTS_PATH/bash/links.sh
linkdots
linkbins
source ~/.bash_profile

PLATFORM=$(uname)
if [ $PLATFORM = "Darwin" ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    brew doctor
    brew bundle --file $SCRIPTS_PATH/Brewfile
fi
