# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "zojax-dev"
  config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/ubuntu-server-10044-x64-vbox4210.box"
  config.vm.hostname = "zojax-dev-box"
  config.vm.network :forwarded_port, guest: 80, host: 80
  config.vm.network :forwarded_port, guest: 8080, host: 8080
  config.vm.network :forwarded_port, guest: 8081, host: 8081
  config.vm.network :private_network, ip: "192.168.33.10"

  config.vm.provider :virtualbox do |vb|
    # vb.gui = true
    vb.customize ["modifyvm", :id, "--memory", "2048"]
  end

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.manifest_file  = "base.pp"
  end

end
