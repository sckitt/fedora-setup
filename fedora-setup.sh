#!/usr/bin/bash
cd ~
# First we setup the repositories so we can install lots of stuff
# Set Virtual Box repo
wget https://raw.githubusercontent.com/sckitt/fedora-setup/master/fedora.packages
# Install Rpmfusion repo
sudo dnf install rpmfusion-free-release-tainted -y
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
# Install balenaEtcher
cd ~/Downloads
curl -s -v https://api.github.com/repos/balena-io/etcher/releases/latest | grep "browser_download_url.*x86_64.rpm" | cut -d : -f 2,3 | tr -d \" | wget -qi -
sudo rpm -ivh balena*
rm balena*
# Install Tixati
sudo dnf install https://download2.tixati.com/download/tixati-2.73-1.x86_64.rpm -y
# Download Tutanota
wget https://mail.tutanota.com/desktop/tutanota-desktop-linux.AppImage
# Download Tor
wget https://www.torproject.org/dist/torbrowser/9.0.10/tor-browser-linux64-9.0.10_en-US.tar.xz
tar xf tor-browser-linux64-9.0.10_en-US.tar.xz
rm tor-browser-linux64-9.0.10_en-US.tar.xz
cd ~
# Install Sublime-Text
sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg
sudo dnf config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo
# Install VSCodium
sudo rpm --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg 
printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=gitlab.com_paulcarroty_vscodium_repo\nbaseurl=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/repos/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg" |sudo tee -a /etc/yum.repos.d/vscodium.repo
# Install youtube-dl
sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
sudo chmod a+rx /usr/local/bin/youtube-dl
# Update cache for package installs
sudo dnf makecache
# grab all packages to install
sudo dnf install $(cat ~/fedora.packages) -y

# Install inject-hatred
git clone https://github.com/sckitt/inject-hatred.git && cd inject-hatred && sudo chmod +x inject-hatred.sh

# Shell beautification Source: https://github.com/ChrisTitusTech/scripts/blob/master/fancy-bash-promt.sh
cd ~
cat ~/fancy-bash-promt.sh >> ~/.bashrc

# Install custom Proton builds
curl -s -v https://api.github.com/repos/GloriousEggroll/proton-ge-custom/releases/latest | grep "browser_download_url.*tar.gz" | cut -d : -f 2,3 | tr -d \" | wget -qi -
wget https://github.com/GloriousEggroll/proton-ge-custom/releases/download/4.21-GE-2/Proton-4.21-GE-2.tar.gz
mkdir ~/.steam/steam/compatibilitytools.d
for i in *.gz; do tar -xvzf "$i"  -C ~/.steam/steam/compatibilitytools.d; done
