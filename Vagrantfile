# -*- mode: ruby -*-
# vim: set ft=ruby :
# -*- mode: ruby -*-
# vim: set ft=ruby :

MACHINES = {
:router1 => {
        :box_name => "centos/7",
        #:public => {:ip => '10.10.10.1', :adapter => 1},
        :net => [
                   {ip: '192.168.255.1', adapter: 2, netmask: "255.255.255.248", virtualbox__intnet: "net1"},
                ]
  },
  :router2 => {
        :box_name => "centos/7",
        :net => [
                   {ip: '192.168.255.2', adapter: 2, netmask: "255.255.255.248", virtualbox__intnet: "net2"},
                ]
  },
  :router3 => {
        :box_name => "centos/7",
        :net => [
                  {ip: '192.168.255.2', adapter: 2, netmask: "255.255.255.248", virtualbox__intnet: "net3"},
                ]
  }
    
}

Vagrant.configure("2") do |config|

  MACHINES.each do |boxname, boxconfig|

    config.vm.define boxname do |box|

        box.vm.box = boxconfig[:box_name]
        box.vm.host_name = boxname.to_s

        boxconfig[:net].each do |ipconf|
          box.vm.network "private_network", ipconf
        end
        if boxconfig.key?(:public)
          box.vm.network "public_network", boxconfig[:public]
        end
        box.vm.provision "shell", inline: <<-SHELL
          mkdir -p ~root/.ssh
                cp ~vagrant/.ssh/auth* ~root/.ssh
        SHELL
        
        case boxname.to_s
        when "router1"
          box.vm.provision "shell", run: "always", inline: <<-SHELL
            sysctl net.ipv4.conf.all.forwarding=1
            yum install -y quagga
            cp /usr/share/doc/quagga-0.99.22.4/zebra.conf.sample /etc/quagga/zebra.conf
            cp /usr/share/doc/quagga-0.99.22.4/ospfd.conf.sample /etc/quagga/ospfd.conf
            systemctl enable zebra.service --now
            SHELL
        when "router2"
          box.vm.provision "shell", run: "always", inline: <<-SHELL
            sysctl net.ipv4.conf.all.forwarding=1
            yum install -y quagga
            cp /usr/share/doc/quagga-0.99.22.4/zebra.conf.sample /etc/quagga/zebra.conf
            cp /usr/share/doc/quagga-0.99.22.4/ospfd.conf.sample /etc/quagga/ospfd.conf
            systemctl enable zebra.service --now
            SHELL
        when "router3"
          box.vm.provision "shell", run: "always", inline: <<-SHELL
            sysctl net.ipv4.conf.all.forwarding=1
            yum install -y quagga
            cp /usr/share/doc/quagga-0.99.22.4/zebra.conf.sample /etc/quagga/zebra.conf
            cp /usr/share/doc/quagga-0.99.22.4/ospfd.conf.sample /etc/quagga/ospfd.conf
            systemctl enable zebra.service --now
            SHELL
          end
      end

  end
  
  
end

