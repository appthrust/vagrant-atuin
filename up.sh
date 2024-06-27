#!/bin/bash

set -e

ENV_FILE=".env"
if [ ! -f "$ENV_FILE" ]; then
    echo "Error: $ENV_FILE not found" >&2
    exit 1
fi

set -a  # Automatically export all variables
source <(sed -e '/^\s*#/d;/^\s*$/d' -e "s/'/'\\\''/g" -e "s/=\(.*\)/='\1'/" "$ENV_FILE")
set +a

# Check if vagrant-libvirt plugin is already installed
if ! vagrant plugin list | grep -q "vagrant-libvirt"; then
    echo "Installing vagrant-libvirt plugin..."
    if ! vagrant plugin install vagrant-libvirt; then
        echo "Error: Failed to install vagrant-libvirt plugin" >&2
        exit 1
    fi
    echo "vagrant-libvirt plugin installed successfully"
else
    echo "vagrant-libvirt plugin is already installed"
fi

if ! vagrant up --provider=libvirt; then
    echo "Error: Failed to start Vagrant VM" >&2
    exit 1
fi
