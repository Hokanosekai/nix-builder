let
  pkgs = import <nixpkgs> {};
  hokanosekai = import ../hokanosekai.nix;
  getOrElse = x: d: if x == "" then d else x;
  getIfNotNullElse = x: d: if x == null then d else x;
  getAsList = x: if x == "" then [] else [x];

  parseBool = val: if val == "true" then true else false;

  # variables
  hostname_env = builtins.getEnv "INPUT_HOSTNAME";
  hostname_default = "rpi_holden";
  hostname = getOrElse hostname_env hostname_default;

  username_env = builtins.getEnv "INPUT_USERNAME";
  username_default = "woile";
  username = getOrElse username_env username_default;

  timezone_env = builtins.getEnv "INPUT_TIME_ZONE";
  timezone_default = "Europe/Amsterdam";
  timezone = getOrElse timezone_env timezone_default;

  ssh_key_env = builtins.getEnv "INPUT_SSH_KEY";
  ssh_key = getAsList ssh_key_env;

  wifi_enabled_env = builtins.getEnv "INPUT_WIFI_ENABLED";
  wifi_enabled_default = true;
  wifi_enabled = getOrElse (parseBool wifi_enabled_env) wifi_enabled_default;

  wifi_network_name_env = builtins.getEnv "INPUT_WIFI_NETWORK_NAME";
  wifi_network_name_default = "";
  wifi_network_name = getOrElse wifi_network_name_env wifi_network_name_default;

  wifi_network_psk_env = builtins.getEnv "INPUT_WIFI_NETWORK_PSK";
  wifi_network_psk_default = "";
  wifi_network_psk = getOrElse wifi_network_psk_env wifi_network_psk_default;

 in {
  hostname = getIfNotNullElse hokanosekai.hostname hostname;
  username = getIfNotNullElse hokanosekai.username username;
  timezone = getIfNotNullElse hokanosekai.timezone timezone;
  ssh_key = hokanosekai.ssh_key ++ ssh_key;
  wifi_enabled = getIfNotNullElse hokanosekai.wifi_enabled wifi_enabled;
  wifi_network_name = getIfNotNullElse hokanosekai.wifi_network_name wifi_network_name;
  wifi_network_psk = getIfNotNullElse hokanosekai.wifi_network_psk wifi_network_psk;
 }