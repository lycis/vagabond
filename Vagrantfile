# This is the default Vagrantfile for using Vagabond.
#
# It is part of the Vagabond framework. 
#
# ! ! ! DO NOT MODIFY ! ! !
#
# Except you know what you are doing :)
# 
# 

require_relative('vagabond/framework/vagabond.rb')

Dir["./vagabond/hooks/*.rb"].each {|file| require file }

# build configuration
$vConf = Vagabond.configure do
  proc = Proc.new {}
  eval(File.read('vagabond/conf/os.cfg'), proc.binding) 
  eval(File.read('vagabond/conf/feature.cfg'), proc.binding) 
  eval(File.read('vagabond/conf/machines.cfg'), proc.binding)
end
