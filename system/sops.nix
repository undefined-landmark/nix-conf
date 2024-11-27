{inputs, ...}: {
  imports = [inputs.sops-nix.nixosModules.sops];
  sops.age.keyFile = "/home/bas/.config/sops/age/keys.txt";
  #sops.defaultSopsFile = ../secrets/ssh.yaml;
  sops.secrets.yubikey1_priv = {};
}
