curl -fsSL https://tailscale.com/install.sh | sh
tailscale up --authkey=$TS_AUTHKEY --hostname=$TS_HOSTNAME
