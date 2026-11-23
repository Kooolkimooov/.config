{ pkgs, inputs, ... }:

{
  home.username = "martin";
  home.homeDirectory = "/home/martin";

  # Set once and leave it. It's not a version to upgrade; it locks in the
  # defaults for files Home Manager creates.
  home.stateVersion = "26.05";

  # Ubuntu (non-NixOS) integration: app menus/icons from Nix, terminfo, zsh completions
  targets.genericLinux.enable = true;
  # GPU integration comes in step 3. Keep it off so the current desktop is untouched.
  targets.genericLinux.gpu.enable = false;

  # Lets Home Manager install and update its own `home-manager` command
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    ripgrep
    fd
    lazygit
  ];
}
