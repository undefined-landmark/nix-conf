# Disk setup

## Partition disks

- Find disk id
    - `fdisk -l`
- Create partitions
    - `fdisk /dev/id`
        - Create 1G partition for EFI
        - Create partition for the rest

## Format disks

- Format EFI partition as FAT32
    - `mkfs.fat -F 32 /dev/idX`
- Encrypt main partition
    - `cryptsetup luksFormat /dev/idX` 
    - `cryptsetup luksOpen /dev/idX cryptroot`
- Format main partition
    - `mkfs.ext4 /dev/mapper/cryptroot`
- Mount main partition
    - `mount -o /dev/mapper/cryptroot /mnt`
- Mount EFI
    - `mount /dev/idX /mnt/boot --mkdir`


# Install NixOS

## Setup Files

- Mount extradata USB partition to home
    - `mount /dev/idX /home/nixos/git --mkdir`
- Copy sops key to `~/.config/sops/age/keys.txt`
- Change paths in
    - `/home/nixos/git/nix-secrets/modules/sops-settings.nix`
    - `/home/nixos/git/nix-conf/flake.nix`
- Update hardware configuration
    - `nixos-generate-config --root /mnt`
    - `cp /mnt/etc/nixos/hardware-configuration.nix ~/git/nix-conf/hosts/X/X`

## Install

`nixos-install --flake ~/git/nix-conf#HOSTNAME`
