Vagrant.configure(2) do |config|
  config.landrush.enabled = true
  config.landrush.host_redirect_dns = false
  config.vm.define "master1" do |master1|
    master1.vm.box = "bento/centos-7.2"
    master1.vm.hostname = "puppet01.vagrant.test"
    master1.vm.provider "virtualbox" do |v|
      v.memory = 2048
    end
    master1.vm.provision "file", source: "files/master", destination: "/tmp/"
    master1.vm.provision "shell", path: "scripts/pre-install-master.sh"
    master1.vm.provision "shell", path: "scripts/install-m1.sh"
  end
#######       MASTER2
  config.vm.define "master2" do |master2|
    master2.vm.box = "bento/centos-7.2"
    master2.vm.hostname = "puppet02.vagrant.test"
    master2.vm.provider "virtualbox" do |v|
      v.memory = 2048
    end
    #master2.vm.provision "file", source: "files/master", destination: "/tmp/"
    #master2.vm.provision "shell", path: "scripts/pre-install-master.sh"
    master2.vm.provision "shell", path: "scripts/install-m2.sh"
  end
#######       BBDD1
  config.vm.define "bbdd1" do |bbdd1|
    bbdd1.vm.box = "bento/centos-7.2"
    bbdd1.vm.hostname = "bbdd1.vagrant.test"
    bbdd1.vm.provision "file", source: "files/bbdd", destination: "/tmp/"
    bbdd1.vm.provision "shell", path: "scripts/install-psql.sh"
  end
#######       BBDD2
  config.vm.define "bbdd2" do |bbdd2|
    bbdd2.vm.box = "bento/centos-7.2"
    bbdd2.vm.hostname = "bbdd2.vagrant.test"
    bbdd2.vm.provision "file", source: "files/bbdd", destination: "/tmp/"
    bbdd2.vm.provision "shell", path: "scripts/install-psql.sh"
  end
#######       HAProxy
  config.vm.define "haproxy" do |haproxy|
    haproxy.vm.box = "bento/centos-7.2"
    haproxy.vm.hostname = "haproxy.vagrant.test"
    haproxy.vm.provision "shell", inline: <<-SHELL
      sudo rpm -ivh /vagrant/files/bbdd/puppet-agent-1.5.3-1.el7.x86_64.rpm
      sudo /opt/puppetlabs/bin/puppet module install puppetlabs-haproxy
      #sudo yum -y install haproxy
      #sudo mv /vagrant/files/haproxy/haproxy.cfg /etc/haproxy/haproxy.cfg
      #sudo haproxy -f /etc/haproxy/haproxy.cfg
    SHELL
  end
########      NODE1
  config.vm.define "node1" do |node1|
    node1.vm.box = "bento/centos-7.2"
    node1.vm.hostname = "node1.vagrant.test"
    node1.vm.provision "shell", inline: <<-SHELL
      #sudo curl -k https://haproxy:8140/packages/current/install.bash | sudo bash
      #sudo /opt/puppetlabs/bin/puppet agent -t
    SHELL
  end
end
