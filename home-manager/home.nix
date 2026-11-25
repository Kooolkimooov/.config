{ pkgs, inputs, ... }:

let
  system = pkgs.stdenv.hostPlatform.system;

  # Scroll-overview plugin, built against the same Hyprland as below (nixpkgs, 0.55.4)
  scrolloverview = pkgs.hyprlandPlugins.mkHyprlandPlugin {
    pluginName = "hyprland-scroll-overview";
    version = "0-unstable-2026-07-15";
    src = pkgs.fetchFromGitHub {
      owner = "yayuuu";
      repo = "hyprland-scroll-overview";
      rev = "cfc23b194ba9378d1606c7aa73060f6ffbe38445";
      hash = "sha256-hjzhIWCmaqVtyCy2ZE1+pM3Q2BvAGuC8zQZSj1AtORA=";
    };
    buildInputs = [ pkgs.lua5_4 ];
    buildPhase = ''
      runHook preBuild
      make all
      runHook postBuild
    '';
    installPhase = ''
      runHook preInstall
      mkdir -p $out/lib
      cp scrolloverview.so $out/lib/libscrolloverview.so
      runHook postInstall
    '';
    meta.description = "Scrollable overview plugin for Hyprland";
  };
in
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

  # Hyprland portal from Nix: Ubuntu's systemd and D-Bus don't look inside
  # ~/.nix-profile, so link its user unit and D-Bus service into ~/.local/share
  systemd.user.packages = [ pkgs.xdg-desktop-portal-hyprland ];
  dbus.packages = [ pkgs.xdg-desktop-portal-hyprland ];

  home.packages = with pkgs; [
    # search / git / terminal
    ripgrep
    fd
    lazygit
    gh
    tmux
    btop
    fastfetch
    restic # backups
    neovim

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

    # Python CLI tools, formerly pipx (pipx venvs don't survive the OS switch)
    yt-dlp
    pre-commit
    python3Packages.jupytext
    ydiff
    qmk
    pay-respects # replaces thefuck (removed from nixpkgs, needs Python < 3.12)

    # texliveFull  # about 5 GB. Uncomment to get the same TeX on both OSes instead of apt's texlive-full.

    # --- desktop: Hyprland 0.55.4 and its tools, all from nixpkgs 26.05 ---
    hyprland
    hypridle
    hyprlock
    hyprpaper
    xdg-desktop-portal-hyprland
    kitty
    mpv
    playerctl
    grim
    slurp
    wl-clipboard
    jq          # used by hyprshot
    libnotify   # notify-send
    scrolloverview
    adw-gtk3
    papirus-icon-theme

    # --- Caelestia (replaces the old `nix profile` entries) ---
    inputs.caelestia-shell.packages.${system}.default
    inputs.caelestia-cli.packages.${system}.default
  ];
}
