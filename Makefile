.PHONY: install gc clean update

install:
	git add .
	nixos-rebuild --flake ./nixos build
	nvd diff /run/current-system result
	sh -c 'echo -n "Update? [Y/N] " && read confirm && [ "$$confirm" = "Y" ] && sudo nixos-rebuild --flake ./nixos switch'
	rm result

home:
	./scripts/install-dotfiles
	# ./scripts/setup-pass

clean:
	sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +3
	sudo nix store gc
	sudo nix store optimise
	df -h /

size:
	@nix path-info -hs --all | sort -rhk2 | sed "s/\/nix\/store\/\([^-]*\)-\(\S*\)\s*\(\S*\)/\1 \3 \2/" | less

update:
	cd nixos && sudo nix flake update
