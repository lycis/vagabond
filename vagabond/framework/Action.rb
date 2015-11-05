#
# Configuration for actions
#

class Action
  attr_reader :name
  
  def initialize(name)
    @name = name
    @triggers = []
  end
  
  def trigger(action)
     unless self.triggers? action
      @triggers.push action
    end
  end
  
  def triggers?(action)
    @triggers.include? action
  end
  
  def triggers
    return @triggers
  end 
end