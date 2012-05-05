require 'yaml'
require 'gracl/config'
require 'gracl/repo'
require 'gracl/user'
require 'gracl/permission'


class Gracl
    def initialize
        @config = Gracl::Config.new
        @users = []
        @groups = []
        load_users
        load_groups
        load "gracl.conf"
    end

    def config
        @config
    end

    def load_users
        Dir["keydir/**/*.pub"].each do |keyfile|
            @users << Gracl::User.new_from_file( keyfile )
        end
    end

    def load_groups
    end

    def run(args)
        print self.to_yaml
    end
end
