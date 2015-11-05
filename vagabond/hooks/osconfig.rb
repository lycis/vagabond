#
# hooks for os specific configurations
#

# configurations for windows server 2012
def os_config_windows(machine)
  Vagrant.configure(2) do |config|
    config.vm.define machine do |m|
      m.vm.synced_folder '.', '/vagrant', nfs: true
      m.vm.communicator = "winrm"
      m.winrm.username = "Administrator"
      m.winrm.password = "vagrant"
      m.vm.network "forwarded_port", host: 33389, guest: 3389, auto_correct: true
    end
  end
end
