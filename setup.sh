# helo
echo "Hello!"
echo "This script will install some basic tools and set some configurations for you."
echo "The Dock might restart a few times. This is normal."
echo "Please enter the user password below to begin the installation."

# ask for the administrator password upfront
sudo -v;

# xcode command line tools
echo "Installing Xcode Command Line Tools..."
xcode-select --install;

# install brew
echo "Installing Homebrew...";
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)";

# Google Cloud SDK
echo "Installing Google Cloud SDK..."
brew install --cask google-cloud-sdk;

# Ruby/Rails
echo "Installing Ruby and Rails..."
brew install ruby;
gem install rails;

# Node.js
echo "Installing Node.js..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
nvm install node --lts;

# Set zshrc
echo "Setting zshrc..."
cp ./zshrc ~/.zshrc;
source ~/.zshrc;

# Clear dock
defaults write com.apple.dock persistent-apps -array;
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/System/Applications/Mail.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="small-spacer-tile";}'
killall Dock;

# Set wallpaper
echo "Setting wallpaper..."
cp ./bg.png ~/Pictures/bg.png;
osascript <<EOD
    tell application "System Events"
        set desktopCount to count of desktops
        repeat with desktopNumber from 1 to desktopCount
            tell desktop desktopNumber
                set picture to "~/Pictures/bg.png"
            end tell
        end repeat
    end tell
EOD
killall Dock;
