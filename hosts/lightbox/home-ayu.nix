{...}: {
  imports = [../../modules/home];

  myHome = {
    enable = true;
    user = "ayu";
    sops.enable = true;
    general.enable = true;
    pkgs-cli.enable = true;
    pkgs-cli-workstation.enable = true;
    pkgs-gui.enable = true;
  };

  programs.vscode.enable = true;
}
