VAGRANTFILE_API_VERSION = "2"

domain = 'dev.inwork.ch'

puppet_nodes = [
  {:hostname => 'puppet',  :ip => '33.33.33.10', :box => 'centos-63-x64', :fwdhost => 8140, :fwdguest => 8140, :ram => 512},
  {:hostname => 'www-centos', :ip => '33.33.33.11', :box => 'centos-63-x64'},
  {:hostname => 'www-ubuntu', :ip => '33.33.33.12', :box => 'ubuntu-server-1204-x64'},
]

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  puppet_nodes.each do |node|
    config.vm.define node[:hostname] do |node_config|
      node_config.vm.box = node[:box]
      #node_config.vm.box_url = 'http://files.vagrantup.com/' + node_config.vm.box + '.box'
      node_config.vm.host_name = node[:hostname] + '.' + domain
      node_config.vm.network :private_network, ip: node[:ip]

      if node[:fwdhost]
        node_config.vm.network :forwarded_port, host: node[:fwdguest], guest: node[:fwdhost]
      end

      memory = node[:ram] ? node[:ram] : 256;

      node_config.vm.provider "virtualbox" do |vb|
        vb.customize [
          'modifyvm', :id,
          '--name', node[:hostname],
          '--memory', memory.to_s
        ]
      end

      if node[:hostname] == 'puppet'
        node_config.vm.synced_folder "./puppet/modules", "/etc/puppet/modules"
        node_config.vm.synced_folder "./puppet/manifests", "/etc/puppet/manifests"
      end

      node_config.vm.provision :puppet do |puppet|
        puppet.manifests_path = 'provision/manifests'
        puppet.module_path = 'provision/modules'
      end
    end
  end
end