require 'yaml'
require 'gracl/config'
require 'gracl/config/repo'


class Gracl
    def initialize
        @config = Gracl::Config.new
        load "gracl.conf"
    end

    def run(args)
        print self.to_yaml
    end  
end
