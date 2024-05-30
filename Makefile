.PHONY: install gc

install:
	sudo nixos-rebuild switch -I nixos-config=/home/alan/projects/.dotfiles/configuration.nix

gc:
	sudo nix-env --delete-generations +5
	sudo nix-store --gc
