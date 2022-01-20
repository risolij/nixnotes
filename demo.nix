# vm.nix => A custom VM to use

{ pkgs, lib, config, ... }:

with lib;
{
  imports = [
    <nixpkgs/nixos/modules/profiles/qemu-guest.nix>
    <nixpkgs/nixos/modules/virtualisation/qemu-vm.nix>
  ];
  networking = {
    hostName = "temppc";
    wireless.enable = true;
    networkmanager.enable = true;
  };

  users.users.tempguy = {
    extraGroups = [ "networkmanager" "wheel" ];
    initialPassword = "test";
    isNormalUser = true;
  };

  virtualisation = {
    cores = 2;
    diskSize = 20 * 1024; # MB
    memorySize = 6 * 1024; # MB
    writableStoreUseTmpfs = false;
  };

  environment.systemPackages = with pkgs; [
    vim
    firefox
  ];

  services = {
    xserver = {
      enable = true;
      layout = "us";
    };
    sshd = {
      enable = true;
    };
    qemuGuest.enable = true;
  };
}

