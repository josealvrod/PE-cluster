Vagrant.configure(2) do |config|
  config.vm.define "master1" do |master1|
    master1.vm.box = "centos/7"
    master1.vm.hostname = "master1"
    master1.vm.network "public_network", use_dhcp_assigned_default_route: true, ip: "192.168.0.164", bridge: "wlo1"
    master1.vm.network "forwarded_port", guest: 443, host: 22102
    master1.vm.network "forwarded_port", guest: 3000, host: 22104
    master1.vm.provider "virtualbox" do |v|
      v.memory = 2048
    end
    master1.vm.provision "file", source: "files/master1", destination: "/tmp/"
    master1.vm.provision "shell", path: "scripts/pre-install-m1.sh"
    master1.vm.provision "shell", path: "scripts/install-m1.sh"
  end
#######       MASTER2
  config.vm.define "master2" do |master2|
    master2.vm.box = "centos/7"
    master2.vm.hostname = "master2"
    master2.vm.network "public_network", use_dhcp_assigned_default_route: true, ip: "192.168.0.165", bridge: "wlo1"
    master2.vm.network "forwarded_port", guest: 443, host: 22103
    master2.vm.provider "virtualbox" do |v|
      v.memory = 2048
    end
    master2.vm.provision "file", source: "files/master2", destination: "/tmp/"
    master2.vm.provision "shell", path: "scripts/pre-install-m2.sh"
    master2.vm.provision "shell", path: "scripts/install-m2.sh"
  end
#######       BBDD
  config.vm.define "bbdd" do |bbdd|
    bbdd.vm.box = "centos/7"
    bbdd.vm.hostname = "bbdd"
    bbdd.vm.network "public_network", use_dhcp_assigned_default_route: true, ip: "192.168.0.166", bridge: "wlo1"
    bbdd.vm.provision "file", source: "files/bbdd", destination: "/tmp/"
    bbdd.vm.provision "shell", path: "scripts/install-psql.sh"
  end
#######       HAProxy
  config.vm.define "haproxy" do |haproxy|
    haproxy.vm.box = "centos/7"
    haproxy.vm.hostname = "haproxy"
    haproxy.vm.network "public_network", use_dhcp_assigned_default_route: true, ip: "192.168.0.167", bridge: "wlo1"
    haproxy.vm.provision "file", source: "files/haproxy/", destination: "/tmp/"
    haproxy.vm.provision "shell", inline: <<-SHELL
      sudo mv /tmp/haproxy/hosts /etc/hosts
      sudo yum -y install haproxy
      sudo mv /tmp/haproxy/haproxy.cfg /etc/haproxy/haproxy.cfg
      sudo haproxy -f /etc/haproxy/haproxy.cfg
    SHELL
  end

########      NODE1
  config.vm.define "node1" do |node1|
    node1.vm.box = "centos/7"
    node1.vm.hostname = "node1"
    node1.vm.network "public_network", use_dhcp_assigned_default_route: true, ip: "192.168.0.168", bridge: "wlo1"
    node1.vm.provision "file", source: "files/node1/", destination: "/tmp/"
    node1.vm.provision "shell", inline: <<-SHELL
      sudo mv /tmp/node1/hosts /etc/hosts
#     sudo curl -k https://haproxy:8140/packages/current/install.bash | sudo bash
#     sudo /opt/puppetlabs/bin/puppet agent -t
    SHELL
  end
end
