/** Include services and programs configuration */
{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    services = {
      ntp.enable = false;
    };

    programs = {
      bash.shellAliases = {
        df = "df -h";
        ".." = "cd ..";
        cat = "bat --style=plain -P";
        # ls = "exa --color=auto";
        # du = "dust -b";
        # neofetch = "macchina";
      };
    };

    # add docker
    virtualisation.docker.enable = true;
  };
}
