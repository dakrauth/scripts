#!/bin/bash
echo Adding ~/.ssh/id_rsa
ssh-add -K ~/.ssh/id_rsa

echo Copying your public key...
pbcopy < ~/.ssh/id_rsa.pub

echo Visit https://github.com/settings/keys to add you new key

echo Installing Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew doctor
brew bundle --file $SCRIPTS_PATH/Brewfile


pushd ~/Downloads

# Get a more recent nightly build of SequelPro that can handle v8 servers
curl -O https://sequelpro.com/builds/Sequel-Pro-Build-97c1b85783.zip

popd
