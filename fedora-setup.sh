#!/usr/bin/bash

get_files () {
    cd ~
    wget https://raw.githubusercontent.com/sckitt/fedora-setup/master/fedora.packages
    wget https://raw.githubusercontent.com/sckitt/fedora-setup/master/fancy-bash-promt.sh
}

enable_repositories () {
    # Install RPM Fusion repo
    sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
    sudo dnf install rpmfusion-free-release-tainted -y
    # Install balenaEtcher repo
    sudo wget https://balena.io/etcher/static/etcher-rpm.repo -O /etc/yum.repos.d/etcher-rpm.repo
    # Install Sublime-Text repo
    sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg
    sudo dnf config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo
    # Install VSCodium repo
    sudo rpm --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg
    printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=gitlab.com_paulcarroty_vscodium_repo\nbaseurl=https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg" | sudo tee -a /etc/yum.repos.d/vscodium.repo 
}

update_cache () {
    sudo dnf makecache
}

install_programs () {
    mkdir -p ~/src && cd ~/src
    # Install Tixati
    sudo dnf install https://download2.tixati.com/download/tixati-2.73-1.x86_64.rpm -y
    # Download Tor
    wget https://www.torproject.org/dist/torbrowser/9.0.10/tor-browser-linux64-9.0.10_en-US.tar.xz
    tar xf tor-browser-linux64-9.0.10_en-US.tar.xz
    rm tor-browser-linux64-9.0.10_en-US.tar.xz
    # Download Tutanota
    mkdir -p tutanota && cd tutanota
    wget https://mail.tutanota.com/desktop/tutanota-desktop-linux.AppImage
    sudo chmod +x tutanota-desktop-linux.AppImage
    cd ..
    # Install youtube-dl
    sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
    sudo chmod a+rx /usr/local/bin/youtube-dl
}

install_packages () {
    sudo dnf install $(cat ~/fedora.packages) -y
}

rice_shell () {
    # Source: https://github.com/ChrisTitusTech/scripts/blob/master/fancy-bash-promt.sh
    cd ~
    cat ~/fancy-bash-promt.sh >> ~/.bashrc
}

install_proton_builds () {
    cd ~/Downloads
    curl -s -v https://api.github.com/repos/GloriousEggroll/proton-ge-custom/releases/latest | grep "browser_download_url.*tar.gz" | cut -d : -f 2,3 | tr -d \" | wget -qi -
    wget https://github.com/GloriousEggroll/proton-ge-custom/releases/download/4.21-GE-2/Proton-4.21-GE-2.tar.gz
    mkdir -p ~/.steam/steam/compatibilitytools.d
    for i in *.gz; do tar -xvzf "$i"  -C ~/.steam/steam/compatibilitytools.d; done
}

main () {
    #get_files
    enable_repositories
    update_cache
    install_programs
    install_packages
    rice_shell
    install_proton_builds
}

main "$@"
