{inputs, ...}: {
  imports = [
    ../../modules/home
    inputs.my-secrets.uploadTools
  ];

  myHome = {
    enable = true;
    user = "bas";
    bas.enable = true;
    sops.enable = true;
    general.enable = true;
    pkgs-cli.enable = true;
  };

  my-secrets.uploadTools.enable = true;
}
