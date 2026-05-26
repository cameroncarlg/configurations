{ pkgs, ... }:

{
  systemd.services.lab-bot = {
    description = "Lab Bot";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];

    serviceConfig = {
      ExecStart = "${pkgs.nodejs}/bin/node /home/cameron/projects/lab-bot/index.js";
      WorkingDirectory = "/home/cameron/projects/lab-bot";
      EnvironmentFile = "/home/cameron/projects/lab-bot/.env";
      User = "cameron";
      Restart = "on-failure";
      RestartSec = "5s";
    };
  };
}
