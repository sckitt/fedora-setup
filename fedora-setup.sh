#!/usr/bin/bash

get_files () {
    cd ~
    wget https://raw.githubusercontent.com/sckitt/fedora-setup/master/fedora.packages
}

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
}

install_programs () {
    mkdir -p ~/src && cd ~/src
    # Install Surfn icons
    git clone https://github.com/erikdubois/Surfn
    cd Surfn && cd surfn-icons && mv * ~/.icons && cd ~/src
    # Install Tixati
    sudo dnf install https://download2.tixati.com/download/tixati-2.73-1.x86_64.rpm -y
    # Download Tutanota
    mkdir -p tutanota && cd tutanota
    wget https://mail.tutanota.com/desktop/tutanota-desktop-linux.AppImage
    sudo chmod +x tutanota-desktop-linux.AppImage
    cd ..
    # Install youtube-dl
    sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
    sudo chmod a+rx /usr/local/bin/youtube-dl

    # TODO: add torbrowser, mullvad-vpn
}

install_packages () {
    sudo dnf install $(cat fedora.packages) -y
}

change_hostname () {
    hostnamectl set-hostname fedora
}

esync () {
    if [[ $(ulimit -Hn) -ge 524288 ]]; then
        echo "Esync enabled"
    else
        while true; do
            read -p "Esync disabled. Do you want to enable? [y/n]" yn
            case $yn in
                [Yy]* ) echo 'DefaultLimitNOFILE=524288' | sudo tee -a /etc/systemd/system.conf \
                        echo 'DefaultLimitNOFILE=524288' | sudo tee -a /etc/systemd/user.conf
                        break;;
                [Nn]* ) exit;;
                * ) echo "Please answer yes or no.";;
            esac
        done
    fi
}

dxvk () {
    #grep --color=always -n "multilib" /etc/pacman.conf
    if grep -Fxq "[multilib]" /etc/pacman.conf
        then
                echo "String found"
        else
                echo "String not found"
    fi
}

setup_gaming () {
    # mpv https://www.youtube.com/watch?v=-jLCjY7PNig
    esync
    dxvk
}

import_settings () {
    sh fedora-import.sh
}

main () {
    #get_files
    #enable_repos
    #update
    #install_programs
    #install_packages
    #change_hostname
    #setup_gaming
    #import_settings
}

main "$@"
