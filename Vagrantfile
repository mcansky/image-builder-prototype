# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box_check_update = false

  config.vm.provider :virtualbox do |vb|
  config.vm.box = "ubuntu/trusty64"

  end

  config.vm.provision "shell", inline: <<-SHELL
    sudo apt-get update
    sudo apt-get install -qq lxc cgroup-lite unzip tmux awscli

    # Install Packer
    curl -sSL -o /tmp/packer.zip https://dl.bintray.com/mitchellh/packer/packer_0.8.2_linux_amd64.zip
    unzip -f -d /usr/bin /tmp/packer.zip

    # Install packer-lxc-builder
    curl -sSL -o /usr/bin/packer-builder-lxc https://s3.amazonaws.com/circle-downloads/packer-builder-lxc-0.0.1
    chmod +x /usr/bin/packer-builder-lxc
  SHELL
end
