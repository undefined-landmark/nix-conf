{inputs, ...}: {
  imports = [
    ../../modules/home
    inputs.my-secrets.uploadTools
  ];

  myHome = {
    enable = true;
    user = "bas";
    sops.enable = true;
    general.enable = true;
    pkgs-cli.enable = true;
  };

  my-secrets.uploadTools.enable = true;
}
