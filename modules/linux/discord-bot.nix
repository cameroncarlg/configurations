{ pkgs, ... }:

{
  systemd.services.discord-bot = {
    description = "Discord Bot";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];

    serviceConfig = {
      ExecStart = "${pkgs.nodejs}/bin/node /home/cameron/projects/discord-bot/index.js";
      WorkingDirectory = "/home/cameron/projects/discord-bot";
      EnvironmentFile = "/home/cameron/projects/discord-bot/.env";
      User = "cameron";
      Restart = "on-failure";
      RestartSec = "5s";
    };
  };
}
