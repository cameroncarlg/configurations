{ pkgs, ... }:

{
  systemd.services.webhook-receiver = {
    description = "Mealie Webhook Receiver";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];

    serviceConfig = {
      ExecStart = "${pkgs.python3}/bin/python3 /home/cameron/webhooks/receiver.py";
      WorkingDirectory = "/home/cameron/webhooks";
      EnvironmentFile = "/home/cameron/webhooks/.env";
      User = "cameron";
      Restart = "on-failure";
      RestartSec = "5s";
    };
  };
}
