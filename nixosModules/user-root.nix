{ inputs, hokanosekai, ... }@flakeContext:
{ config, lib, pkgs, ... }:
let
  ssh_pub_files = lib.filterAttrs (k: v: v == "regular" && lib.hasSuffix ".pub" k) (builtins.readDir ../authorized_keys);
  ssh_files_list = lib.mapAttrsToList (k: v: builtins.readFile "${../authorized_keys}/${k}") ssh_pub_files;
in
{
  config = {
    users = {
      groups.media = { };

      users = {
        "${hokanosekai.username}" = {
          isNormalUser = true;
          # initialPassword = "nixos";
          extraGroups = [
            "wheel"
            "docker"
            "podman" # if exists
            "disk"
            "media" # access to media files
          ];
          openssh.authorizedKeys.keys = ssh_files_list ++ hokanosekai.ssh_key;
        };
      };
    };
  };
}
