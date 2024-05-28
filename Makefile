.PHONY: install

install:
	sudo nixos-rebuild switch -I nixos-config=/home/alan/projects/.dotfiles/configuration.nix
