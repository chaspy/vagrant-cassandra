VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/xenial64"

  config.vm.define :cassandra0 do | cassandra |
    cassandra.vm.hostname = "cassandra0"
    cassandra.vm.network :private_network, ip: "192.168.33.200"#, virtualbox__intnet: "intnet"
    cassandra.vm.provision :shell, :path => "./init.sh",:privileged   => true
  end

  config.vm.define :cassandra1 do | cassandra |
    cassandra.vm.hostname = "cassandra1"
    cassandra.vm.network :private_network, ip: "192.168.33.201"#, virtualbox__intnet: "intnet"
    cassandra.vm.provision :shell, :path => "./init.sh",:privileged   => true
  end

  config.vm.define :cassandra2 do | cassandra |
    cassandra.vm.hostname = "cassandra2"
    cassandra.vm.network :private_network, ip: "192.168.33.202"#, virtualbox__intnet: "intnet"
    cassandra.vm.provision :shell, :path => "./init.sh",:privileged   => true
  end
end
