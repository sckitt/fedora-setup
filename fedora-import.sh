#!/usr/bin/bash

import_settings () {
    cp -r $(pwd)/dotfiles/.config ~
    cp -r $(pwd)/dotfiles/.newsboat ~
    cp -r $(pwd)/dotfiles/.themes ~
    cp $(pwd)/dotfiles/.bashrc-personal ~
}

main () {
	import_settings
}

main "$@"
