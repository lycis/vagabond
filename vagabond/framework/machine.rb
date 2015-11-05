#
# class for storing machine configurations that we need
# inside the framework
#

class Machine
  
  attr_reader :name
  
  def initialize(conf, name)
    @name = name
    @conf = conf
    
    if self.defined?
      raise "redefinition of machine '#{name}'"
    end
    
    # set default values
    @opSys     = nil
    @features = []
  end
  
  # configure vm to use the correct box
  def os(osName)  
    opSys = @conf.getOs(osName)
  
    # check if os is valid
    if opSys == nil
      raise "operating system '#{osName}' for machine '#{@name}' is not supported"
    end
  
    # configure vagrant for this vm
    Vagrant.configure(2) do |config|
      config.vm.define @name do |vm|
        vm.vm.box = opSys.name
        vm.vm.box_url = opSys.box
        vm.vm.box_check_update = true
      end
    end
  
    # configure general stuff for os
    if opSys.hook('configuration') != nil
      opSys.hook('configuration').each do |h|
        send(h, @name)
      end
    end
    
    @opSys = opSys
  end
  
  def defined?
    # check if machine was already defined to prevent overwrites
    if @conf.getMachine(@name) != nil
     return true
    end    
    
    return false
  end
  
  # define memory provided for the machine
  def memory(mb)
    Vagrant.configure(2) do |config|
      config.vm.define @name do |m|
        m.vm.provider :virtualbox do |vb|
          vb.memory = mb
        end
      end
    end
  end
  
  # configure number of cpus
  def cpus(num)
    Vagrant.configure(2) do |config|
      config.vm.define @name do |m|
        m.vm.provider :virtualbox do |vb|
          vb.cpus = num
        end
      end
    end
  end
  
  def has_feature?(feature)
    return @features.include? feature
  end
  
  # add a feature
  def install(feature, *args)
    # check if already installed
    if has_feature? feature
      return
    end
    
    if @opSys == nil
      raise "no operating system configured for vm #{@name}"
    end
  
    script = "./scripts/#{@opSys.type}/install_#{feature}.#{@opSys.scriptExtension}"
    
    # check if feature is installable (aka scripts exist)
    unless File.file? script
      raise "#{@name} ==> no such feature: #{feature}"
    end
    
    # check and install dependencies
    featureConf = @conf.getFeature(feature)
    if featureConf != nil and featureConf.dependencies != nil
      featureConf.dependencies.each do |dep|
        install(dep)
      end
    end
    
    # call according script
    Vagrant.configure(2) do |config|
      config.vm.define @name do |m|
        m.vm.provision "shell" do |s|
          s.path = script
          if(args.length > 0)
            s.args = args    
          end
        end
      end
    end
    
    call_triggers(featureConf)
    
    # add to list of installed features
    @features.push feature
      
  end
  
  # run an action script
  def action(action, *args)
    if @opSys == nil
      raise "no operating system configured for vm #{@name}"
    end
  
    script = "./scripts/#{@opSys.type}/action_#{action}.#{@opSys.scriptExtension}"
    
    # check if action script exists
    unless File.file? script
      raise "#{@name} ==> no such action: #{action}"
    end
    
    # call according script
    Vagrant.configure(2) do |config|
      config.vm.define @name do |m|
        m.vm.provision "shell" do |s|
          s.path = script
          if(args.length > 0)
            s.args = args    
          end
        end
      end
    end
    
    # call triggers
    actConf = @conf.getAction(action)
    call_triggers(actConf)
  end
  
  def call_triggers(actConf)
    if actConf != nil and actConf.triggers != nil
      actConf.triggers.each do |a|
        action(a)
      end
    end
  end
  
  def ip(newIp)
    Vagrant.configure(2) do |config|
      config.vm.define @name do |m|
        m.vm.network "private_network", ip: newIp
      end
    end
    
    @ip = newIp
  end
 
end
