{inputs, ...}: {
  sops.age.keyFile = "/home/bas/.config/sops/age/keys.txt";
  sops.defaultSopsFile = "${inputs.secrets}/secrets/ssh.yaml";
}
