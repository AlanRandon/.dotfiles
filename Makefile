.PHONY: install gc

install:
	sudo nixos-rebuild switch -I nixos-config=/home/alan/projects/.dotfiles/configuration.nix

gc:
	sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations +5
	sudo nix-store --gc
	make install
