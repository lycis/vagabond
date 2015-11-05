#
# loads the complete framework class set
#

require_relative('Configuration')
require_relative('OperatingSystem')
require_relative('Feature')

class Vagabond
  def self.configure(&block)
    conf = Configuration.new
    conf.instance_exec &block
    return conf
  end
end