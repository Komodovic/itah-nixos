{ ... }: {
  flake.modules.nixos.maintenance = { pkgs, ... }: {
    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    nix.optimise.automatic = true;
    nix.optimise.dates = [ "weekly" ];

    systemd.services.nixos-upgrade-push = {
      description = "Update flake inputs, rebuild, commit & push /etc/nixos";
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];
      path = with pkgs; [ nixos-rebuild nix git openssh coreutils ];
      serviceConfig = {
        Type = "oneshot";
        Environment = "HOME=/root";
      };
      script = ''
        set -euo pipefail
        export GIT_SSH_COMMAND="ssh -i /home/itah/.ssh/id_ed25519 -o IdentitiesOnly=yes -o StrictHostKeyChecking=accept-new"
        git config --global --add safe.directory /etc/nixos

        cd /etc/nixos

        nix flake update

        nixos-rebuild switch --flake /etc/nixos#nixos

        if ! git diff --quiet HEAD --; then
          git add -A
          git commit -m "auto: flake update $(date -u '+%Y-%m-%d %H:%M UTC')"
          git push origin main
        fi

        chown -R itah:users /etc/nixos
      '';
    };

    systemd.timers.nixos-upgrade-push = {
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "Sun 03:00";
        Persistent = true;
        RandomizedDelaySec = "1h";
      };
    };
  };
}
