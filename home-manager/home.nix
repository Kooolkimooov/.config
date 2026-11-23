{ pkgs, inputs, ... }:

{
  home.username = "martin";
  home.homeDirectory = "/home/martin";

  # Set once and leave it. It's not a version to upgrade; it locks in the
  # defaults for files Home Manager creates.
  home.stateVersion = "26.05";

  # Ubuntu (non-NixOS) integration: app menus/icons from Nix, terminfo, zsh completions
  targets.genericLinux.enable = true;
  # NVIDIA libraries for Nix programs, provided at /run/opengl-driver (like on NixOS).
  # The version MUST match the system driver (nvidia-driver-595-open). After an Ubuntu
  # driver update: change version + sha256, run `home-manager switch`, then the sudo
  # command it prints.
  targets.genericLinux.gpu = {
    enable = true;
    nvidia = {
      enable = true;
      version = "595.99.02";
      sha256 = "sha256-6HR3lYv3YwcFSTJL1a1slI66btIQ5EAFs+/4SUD24ew=";
    };
  };

  # Lets Home Manager install and update its own `home-manager` command
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # search / git / terminal
    ripgrep
    fd
    lazygit
    gh
    tmux
    btop
    fastfetch

    # media (CLI)
    ffmpeg
    feh

    # language runtimes for user tools (not used by ROS/mc_rtc builds)
    go
    nodejs_22

    # clang-format 22 only, under both names. Not clangd/clang-tidy,
    # which would change your editor's C++ setup.
    (runCommand "clang-format-22" { } ''
      mkdir -p $out/bin
      ln -s ${llvmPackages_22.clang-unwrapped}/bin/clang-format $out/bin/clang-format
      ln -s ${llvmPackages_22.clang-unwrapped}/bin/clang-format $out/bin/clang-format-22
    '')

    # texliveFull  # about 5 GB. Uncomment to get the same TeX on both OSes instead of apt's texlive-full.
  ];
}
