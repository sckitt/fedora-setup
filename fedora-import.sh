#!/usr/bin/bash

import_settings () {
    cp -r $(pwd)/dotfiles/.config ~
    cp -r $(pwd)/dotfiles/.newsboat ~
    cp -r $(pwd)/dotfiles/.themes ~
    cp -r $(pwd)/dotfiles/.w3m ~
    cp $(pwd)/dotfiles/.bashrc-personal ~
    cp $(pwd)/dotfiles/.bashrc-fr.sh ~
}

main () {
	import_settings
}

main "$@"
