# NixOS Configuration

This repository contains the NixOS configuration for a number of machines.


## Directories

In the `./hosts` directory the host specific configuration can be found.

Each host configuration mainly uses modules that are defined in `./modules`.
Modules are split up in modules for home-manager, `./modules/home`, and for NixOS, `./modules/system`.
The main modules are `myHome`, `mySys` and `myServer`:
- `myHome` contains home-manager configuration and is used across all machines.
- `mySys` contains NixOS configuration and is used across all machines.
- `myServer` contains NixOS services configuration and is mainly used on my server. But could of course be used on any machine.

In `./docs` documentation can be found about the installation of NixOS, the way I typically do it.


## Secrets & Private Variables

Secrets are managed using `sops-nix`.
The encrypted secrets are stored in a separate private repository.

Additionally this config contains private variables.
These variables are sensitive, like an email address or file path, but unlike a password that you don't want in your nix store.
To keep them out of this public repository they are defined in the same private repository as used for `sops-nix`.
