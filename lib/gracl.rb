require 'yaml'
require 'gracl/config'
require 'gracl/config/repo'
require 'gracl/config/repo/permission'


class Gracl
    def initialize
        @config = Gracl::Config.new
        load "gracl.conf"
    end

    def config
        @config
    end

    def run(args)
        print self.to_yaml
    end  
end
