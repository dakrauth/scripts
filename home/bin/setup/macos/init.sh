echo Adding ~/.ssh/id_rsa
ssh-add -K ~/.ssh/id_rsa

echo Copying your public key...
pbcopy < ~/.ssh/id_rsa.pub

echo Visit https://github.com/settings/keys to add you new key

mkdir -p ~/Library/LaunchAgents/

cat << EOF > ~/Library/LaunchAgents/com.david.bak.plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.david.bak</string>
    <key>ProgramArguments</key>
    <array>
        <string>/Users/david/bin/dbbak</string>
    </array>
    <key>QueueDirectories</key>
    <array/>
    <key>StartCalendarInterval</key>
    <dict>
        <key>Hour</key>
        <integer>3</integer>
        <key>Minute</key>
        <integer>35</integer>
    </dict>
    <key>WatchPaths</key>
    <array/>
</dict>
</plist>
EOF

xcode-select -p # determine if xcode is installed
sudo xcodebuild -license
xcode-select --install
sudo mkdir /usr/local
sudo chown $(whoami) /usr/local
cd /usr/local

echo Installing Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew doctor
brew bundle --file $SCRIPTS_PATH/macos/Brewfile

mysql_config_editor set --password

brew cask outdated
chflags nohidden ~/Library

#mysql_secure_installation
