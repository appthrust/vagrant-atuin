sh <(curl -L https://nixos.org/nix/install)

source /home/vagrant/.profile

mkdir -p /home/vagrant/.config/nix
echo 'experimental-features = nix-command flakes' >> /home/vagrant/.config/nix/nix.conf

nix profile install "github:atuinsh/atuin"
