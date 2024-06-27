# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-24.04"
  config.vm.box_version = "202404.26.0"
  
  config.vm.provider :libvirt do |domain|
    domain.default_prefix = ENV["USER"] + "-atuin-"
    domain.cpu_mode = "host-passthrough"
    domain.cpus = 4
    domain.memory = 2048
    domain.nested = true
    domain.storage :file, :size => '32G'
    domain.disk_driver :bus => 'scsi', :discard => 'unmap', :cache => 'writeback'
  end
  
  config.vm.provision "shell",
    inline: <<-SHELL
      apt-get update

      echo -e "n\np\n1\n\n\nw" | sudo fdisk /dev/vdb
      sudo pvcreate /dev/vdb1
      sudo vgextend ubuntu-vg /dev/vdb1
      sudo lvextend -l +100%FREE /dev/ubuntu-vg/ubuntu-lv
      sudo resize2fs /dev/ubuntu-vg/ubuntu-lv
    SHELL
    
  if ENV['ENABLE_TAILSCALE'] == 'true'
    config.vm.provision "shell",
      privileged: true,
      env: {
        "TS_AUTHKEY" => ENV["TS_AUTHKEY"],
        "TS_HOSTNAME" => ENV["TS_HOSTNAME"],
      },
      path: "provisioning/tailscale.sh"
  end
  
  if ENV['ENABLE_NIX'] == 'true'
    config.vm.provision "shell",
      privileged: false,
      path: "provisioning/nix.sh"
  end
  
  config.vm.provision "shell",
    privileged: true,
    path: "provisioning/docker.sh"

  config.vm.provision "shell",
    privileged: false,
    path: "provisioning/atuin.sh"

  if ENV['ENABLE_PUBKEY'] == 'true'
    config.vm.provision "shell",
      privileged: false,
      env: {
        "SSH_PUBLIC_KEY" => ENV["SSH_PUBLIC_KEY"],
      },
      path: "provisioning/pubkey.sh"
  end
end
