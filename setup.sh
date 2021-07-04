export SCRIPTS_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd -P )"
$SCRIPTS_PATH/link.sh

mkdir -p ~/.ssh
chmod 700 ~/.ssh
echo Skip the passphrase
ssh-keygen -t rsa -b 4096 -C "dakrauth@gmail.com"
eval "$(ssh-agent -s)"

echo Installing nvm
ver=$(curl -sI https://github.com/nvm-sh/nvm/releases/latest | grep "^location:" | cut -d" " -f2)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/${ver##*/}/install.sh | bash

PLATFORM=$(uname)
if [ $PLATFORM = "Darwin" ]; then
    ./setup/macos/init.sh
fi
