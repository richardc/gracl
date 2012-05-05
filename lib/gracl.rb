require 'rubygems'
require 'yaml'
require 'clamp'

# These will all be classes I use later, but there I want to just say
# 'class Gracl::Commmand::Foo' rather than doing the whole subclass
# fiesta.  I hate you ruby.
class Gracl
    class Command < Clamp::Command
    end
end

require 'gracl/config'
require 'gracl/repo'
require 'gracl/user'
require 'gracl/group'
require 'gracl/permission'
require 'gracl/command/dump'
require 'gracl/command/shell'
require 'gracl/command/install'
require 'gracl/command'


class Gracl
    def initialize
        @config = Gracl::Config.instance
        load "gracl.conf"
    end

end
