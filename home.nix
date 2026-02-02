{ config, pkgs, inputs, ... }:

{
  imports = [
    ./vim.nix
    ./tmux.nix
  ];

  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    git
    universal-ctags
  ];
}
