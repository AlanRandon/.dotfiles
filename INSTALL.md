## Installation Media

Download a [NixOS](https://nixos.org/download/) ISO and [flash it to a USB](https://nixos.wiki/wiki/NixOS_Installation_Guide#Making_the_installation_media).

## Networking

Set up an Internet connection, preferably using a wired connection.

## Partitioning

Use `sudo cfdisk` and edit the partitions until they are as they should be. My typical layout has a boot partition, a root partition and a swap partition. Write these and check the existence of new devices using `sudo lsblk`. Note which device corresponds to each partition.

## Create Filesystems and Swap

Create filesystems for and label the partitions - this will make them available under `/dev/disk/by-label/LABEL`.

```sh
# Make a FAT32 fs on the boot partition
sudo mkfs.fat -F 32 /dev/path/to/boot/partition
# Label the FAT32 partition "NIXBOOT"
sudo fatlabel /dev/path/to/boot/partition NIXBOOT
# Make an EXT4 fs on the root partition and label it "NIXBOOT"
sudo mkfs.ext4 /dev/path/to/root/partition -L NIXROOT
# Make swap on the swap partition and label it "NIXSWAP"
sudo mkswap /dev/path/to/swap/partition -L NIXSWAP
```

## Mount Filesystems and Enable Swap

```sh
# Mount the root partition
sudo mount /dev/disk/by-label/NIXROOT /mnt
# Create the `/boot` directory on the root partition
sudo mkdir -p /mnt/boot
# Mount the boot partition
sudo mount /dev/disk/by-label/NIXBOOT /mnt/boot
# Enable swap on the swap partition
sudo swapon -L NIXSWAP
```

## Clone this repo

```sh
sudo mkdir -p /mnt/home/alan/projects
sudo git clone https://github.com/AlanRandon/.dotfiles /mnt/home/alan/projects/.dotfiles
cd /mnt/home/alan/projects/.dotfiles
```

## Choose a Hostname

Pick a hostname - using a Greek Philosopher's name seems like a funny suggestion - this can be used to refer to the machine.

## Create Machine Specific Configuration

- Create some basic hardware configuration with `sudo sh -c "nixos-generate-config --show-hardware-config --root /mnt > nixos/<HOSTNAME>/hardware-configuration.nix"`.
- Check (and potentially edit this) with `sudo vim nixos/<HOSTNAME>/hardware-configuration.nix`.
- Create a `nixos/<HOSTNAME>/default.nix` with configuration similar to the following:

```nix
{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../nixosModules
  ];

  networking.hostName = "<HOSTNAME>";

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    # Use the systemd-boot EFI boot loader.
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };
}
```

- Add the hostname to the list of outputs in `nixos/flake.nix` with configuration similar to the following:

```nix
{
  nixosConfigurations = {
    <HOSTNAME> = mkNixosSystem {
      system = <ARCHITECTURE>; # usually "x86_64-linux"
      modules = [ ./<HOSTNAME> ];
    };
  };
}
```

## Run the Installation

Make sure the configuration is as desired, and the Internet connection is available, and run `nixos-install --no-channel-copy --flake ./nixos#<HOSTNAME>`. This will take some time. Set up a root password when prompted.

## User configuration

Try to `reboot` and log in as root - be sure to change the command in tuigreet from `Hyprland` to `zsh`. The user will be called `alan` per the existing configuration unless changed. A user password must be set using `passwd <USERNAME>`. Switch to the user using `su <USERNAME>`.
Run `chown -R <USERNAME> /home/<USERNAME>` to gain ownership of your own home directory.

## Userspace configuration

Run `/home/<USERNAME>/projects/.dotfiles/scripts/install-dotfiles` to install additional configuration files (e.g. window manager and vim configuration).
Exit the `root` login and login as the user - use `Win+Enter` to start a new terminal - zinit will install zsh plugins automatically. Use the `vim` alias to enter neovim for lazy to install neovim plugins, try a `:checkhealth` when this is done to check the vim environment is configured as should be.
Open firefox with `Win+b` and ensure the appropriate extensions are installed. Userstyles can be downloaded from the [catppuccin userstyles customizer](https://catppuccin-userstyles-customizer.uncenter.dev) and imported into the Stylus extension.

## Secrets

Clone `~/smb-secrets`, `~/scripts/motd-location` and `~/scripts/apod-api-key` files from some other machine, as well as `~/.ssh`.
