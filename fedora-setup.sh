#!/usr/bin/bash

enable_repos () {
    # Enable RPM Fusion repos
    sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
    sudo dnf install rpmfusion-free-release-tainted -y
    # Import Sublime-Text repo
    sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg
    sudo dnf config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo
    # Import VSCodium repo
    sudo rpm --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg
    printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=gitlab.com_paulcarroty_vscodium_repo\nbaseurl=https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg" | sudo tee -a /etc/yum.repos.d/vscodium.repo 
}

update () {
    sudo dnf makecache
)

install_packages () {
    sudo dnf install $(cat fedora.packages) -y
    # Install Tixati
    sudo dnf install https://download2.tixati.com/download/tixati-2.73-1.x86_64.rpm -y
    # Install youtube-dl
    sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
    sudo chmod a+rx /usr/local/bin/youtube-dl
}

import_settings () {
    sh fedora-import.sh
}

main () {
    enable_repos
    update
    install_packages
    import_settings
}

main "$@"
