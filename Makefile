.PHONY: install gc

install:
	git add .
	sudo nixos-rebuild --flake ./nixos# switch

clean:
	sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations +5
	sudo nix-store --gc

update:
	cd nixos && sudo nix flake update
