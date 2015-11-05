#!ruby
# 
# Classes / DSL for configurations
#
require_relative('OperatingSystem')
require_relative('Action')
require_relative('Feature')
require_relative('machine')

class Configuration  

  def initialize
    @osdef = {}
    @actdef = {}
    @featuredef = {}
    @machines = {}
  end
  
  def os(name, &block)
    os = OperatingSystem.new name
    r = os.instance_exec &block
    @osdef[name] = os
    return os
  end
  
  def getOs(name)  
    return @osdef[name]
  end
  
  def action(name, &block)
    act = Action.new name
    act.instance_exec &block
    @actdef[name] = act
    return act
  end
  
  def getAction(name)
    return @actdef[name]
  end
  
  def feature(name, &block)
    feature = Feature.new name
    feature.instance_exec &block
    @featuredef[name] = feature
    return feature
  end
  
  def getFeature(name)
    return @featuredef[name]
  end
  
  def machine(name, &block)
    machine = Machine.new(self, name)
    machine.instance_exec &block
    @machines[name] = machine
    return machine
  end
  
  def getMachine(name)
    return @machines[name]
  end
  
  def vm(name, &block)
    machine(name, &block)
  end
end