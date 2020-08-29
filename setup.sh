#!/bin/bash
export SCRIPTS_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd -P )"
source $SCRIPTS_PATH/bash/links.sh
linkdots
linkbins
source ~/.bash_profile

mkdir -p ~/.ssh
chmod 700 ~/.ssh
echo Skip the passphrase
ssh-keygen -t rsa -b 4096 -C "dakrauth@gmail.com"
eval "$(ssh-agent -s)"

cat << EOF > ~/.ssh/config
Host *
    AddKeysToAgent yes
    UseKeychain yes
    IdentityFile ~/.ssh/id_rsa
EOF


echo Installing nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

PLATFORM=$(uname)
if [ $PLATFORM = "Darwin" ]; then
    ./setup/macos/init.sh
fi
