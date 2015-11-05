#
# Definition of OS config entries
#

require_relative('Configuration')

class OperatingSystem  

  attr_reader :name
  
  def initialize(name)
    @name             = name
    @box              = ''
    @scriptExtension  = ''
    @osName           = ''
    @hooks            = {}
  end
  
  def box(*box)    
    if box.length > 0
      @box = box[0]
    end
    
    return @box
  end
  
  def scriptExtension(*ext)
    if ext.length > 0
      @scriptExtension = ext[0]
    end
    
    return @scriptExtension
  end
  
  def type(*osName)
    if osName.length > 0
      @osName = osName[0]
    end
    
    return @osName
  end
  
  def hook(hook, *symbols)
    if symbols.length > 0
      @hooks[hook] = symbols
    end
    
    return @hooks[hook]
  end
  
end