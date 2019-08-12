# -*- mode: ruby -*-
# vim: set ft=ruby :
# -*- mode: ruby -*-
# vim: set ft=ruby :

MACHINES = {
:router1 => {
        :box_name => "centos/7",
        #:public => {:ip => '10.10.10.1', :adapter => 1},
        :net => [
                   {ip: '192.168.10.2', adapter: 2, netmask: "255.255.255.248", virtualbox__intnet: "routernet1"},
                   {ip: '192.168.20.2', adapter: 3, netmask: "255.255.255.248", virtualbox__intnet: "routernet2"},
                ]
  },
  :router2 => {
        :box_name => "centos/7",
        :net => [
                   {ip: '192.168.10.1', adapter: 2, netmask: "255.255.255.248", virtualbox__intnet: "routernet1"},
                   {ip: '192.168.30.1', adapter: 3, netmask: "255.255.255.248", virtualbox__intnet: "routernet3"},
                ]
  },
  :router3 => {
        :box_name => "centos/7",
        :net => [
                    {ip: '192.168.20.1', adapter: 2, netmask: "255.255.255.248", virtualbox__intnet: "routernet2"},
                    {ip: '192.168.30.2', adapter: 3, netmask: "255.255.255.248", virtualbox__intnet: "routernet3"},
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
            sysctl -w net.ipv4.conf.eth1.rp_filter=0
            sysctl -w net.ipv4.conf.eth2.rp_filter=0
            sysctl -w net.ipv4.conf.eth3.rp_filter=0
            yum install -y quagga
            # cp /vagrant/zebra1.conf /etc/quagga/zebra.conf
            # cp /vagrant/ospf1.conf /etc/quagga/ospfd.conf
            setsebool -P zebra_write_config 1
            chown -R quagga:quaggavt /etc/quagga/
            systemctl enable zebra.service --now
            systemctl enable ospfd.service --now
            SHELL
        when "router2"
          box.vm.provision "shell", run: "always", inline: <<-SHELL
            sysctl net.ipv4.conf.all.forwarding=1
            yum install -y quagga
            # cp /vagrant/zebra2.conf /etc/quagga/zebra.conf
            # cp /vagrant/ospf2.conf /etc/quagga/ospfd.conf
            setsebool -P zebra_write_config 1
            chown -R quagga:quaggavt /etc/quagga/
            systemctl enable zebra.service --now
            systemctl enable ospfd.service --now
            SHELL
        when "router3"
          box.vm.provision "shell", run: "always", inline: <<-SHELL
            sysctl net.ipv4.conf.all.forwarding=1
            yum install -y quagga
            # cp /vagrant/zebra3.conf /etc/quagga/zebra.conf
            # cp /vagrant/ospf3.conf /etc/quagga/ospfd.conf
            setsebool -P zebra_write_config 1
            chown -R quagga:quaggavt /etc/quagga/
            systemctl enable zebra.service --now
            systemctl enable ospfd.service --now
            SHELL
          end
      end

  end
  
  
end

