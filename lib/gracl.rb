require 'yaml'
require 'gracl/config'
require 'gracl/repo'
require 'gracl/user'
require 'gracl/group'
require 'gracl/permission'


class Gracl
    def initialize
        @config = Gracl::Config.new
        load "gracl.conf"
    end

    def run(args)
        print self.to_yaml
    end
end
