# fedora-setup
Setup Script for [Fedora Xfce](https://spins.fedoraproject.org/xfce/)

Video Walkthrough https://www.youtube.com/watch?v=400g2uVV090

Use the following command to run the script easily in one run:

    wget https://raw.githubusercontent.com/sckitt/fedora-setup/master/fedora-setup.sh && sudo chmod +x fedora-setup.sh && ./fedora-setup.sh

Below is everything included in this script:

1. Enable rpmfusion repositories (free, non-free, tainted)
2. Update the system
3. Install programs from 3rd-party sources
4. Install packages from rpmfusion
**See complete listing @ https://github.com/sckitt/fedora-setup/blob/master/fedora.packages
5. Install [firefox-setup](https://github.com/sckitt/firefox-setup)
6. Change hostname
7. Setup gaming
8. Import settings

Below is a list of optional/manual installs:

* setup-gaming ([video walkthrough](https://youtu.be/-jLCjY7PNig?t=466))
    * [DXVK](https://github.com/lutris/docs/blob/master/HowToDXVK.md)
    * [Wine dependencies](https://github.com/lutris/docs/blob/master/WineDependencies.md)
    * [driver support](https://github.com/lutris/docs/blob/master/InstallingDrivers.md)
    * [graphics drivers](https://github.com/doitsujin/dxvk/wiki/Driver-support)
* [torbrowser](https://www.torproject.org/download/)
* [mullvad-vpn](https://mullvad.net/en/download/linux/)