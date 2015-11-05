#
# Describes the configuration of a feature
#
require_relative('Action')

class Feature < Action 
  def initialize(name)
    super(name)
    @dependencies = []
  end  
  
  def dependsOn(feature)
    unless @dependencies.include? feature
      @dependencies.push feature
    end
  end
  
  def dependsOn?(feature)
    @dependencies.include? feature
  end
  
  def dependencies
    @dependencies
  end
end