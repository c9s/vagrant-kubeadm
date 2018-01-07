# -*- mode: ruby -*-
# vi: set ft=ruby :
NUM_NODE = 2
KUBEADM_POD_NETWORK_CIDR = "10.244.0.0/16"
KUBEADM_TOKEN = "29c663.4e1b73743dfdcaf1"
KUBEADM_TOKEN_TTL = 0

MASTER_IP = "192.168.26.10"
NODE_IP_NW = "192.168.26."

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  # config.vm.box = "base"
  config.vm.box = "ubuntu/xenial64"

  # The following config requires hostmanager:
  # config.hostmanager.enabled = true
  # config.hostmanager.manage_guest = true

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.
  config.vm.provision "install-docker", type: "shell", :path => "ubuntu/install-docker.sh"
  config.vm.provision "install-kubeadm", type: "shell", :path => "ubuntu/install-kubeadm.sh"

  config.vm.define "master" do |master|
    master.vm.hostname = "master"
    master.vm.network :private_network, ip: MASTER_IP

    master.vm.provision "shell", inline: <<-SHELL
        kubeadm init \
            --apiserver-advertise-address=#{MASTER_IP} \
            --pod-network-cidr=#{KUBEADM_POD_NETWORK_CIDR} \
            --token #{KUBEADM_TOKEN} --token-ttl #{KUBEADM_TOKEN_TTL}
    SHELL

    master.vm.provision "install-kubeconfig", :type => "shell", :path => "vagrant/install-kubeconfig.sh"
    master.vm.provision "allow-bridge-nf-traffic", :type => "shell", :path => "ubuntu/allow-bridge-nf-traffic.sh"
    master.vm.provision "install-flannel", :type => "shell", :path => "vagrant/install-flannel.sh"
  end

  (1..NUM_NODE).each do |i|
    config.vm.define "node-#{i}" do |node|
        node.vm.hostname = "node-#{i}"
        node.vm.network :private_network, ip: NODE_IP_NW + "#{10 + i}"

        node.vm.provision "allow-bridge-nf-traffic", :type => "shell", :path => "ubuntu/allow-bridge-nf-traffic.sh"
        # --discovery-token-unsafe-skip-ca-verification might be required for custom generated token
        node.vm.provision "shell", inline: <<-SHELL
        kubeadm join --token #{KUBEADM_TOKEN} #{MASTER_IP}:6443 --discovery-token-unsafe-skip-ca-verification
        SHELL
    end
  end
end
