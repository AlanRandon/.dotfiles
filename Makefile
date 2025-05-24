.PHONY: install gc clean update

install:
	git add .
	sudo nixos-rebuild --flake ./nixos# switch

clean:
	sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +3
	sudo nix store gc
	sudo nix store optimise
	dysk

size:
	@nix path-info -hs --all | sort -rhk2 | sed "s/\/nix\/store\/\([^-]*\)-\(\S*\)\s*\(\S*\)/\1 \3 \2/" | less

update:
	cd nixos && sudo nix flake update
