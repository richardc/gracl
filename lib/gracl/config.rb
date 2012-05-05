require 'singleton'
class Gracl
end

class Gracl::Config
    include Singleton
    attr_accessor :repos, :users, :groups
    def initialize
        self.repos = []
        self.users = []
        self.groups = []
        load_users
    end

    def self.setup(&block)
        self.instance.instance_eval &block
    end

    def load_users
        Dir["keydir/**/*.pub"].each do |keyfile|
            users << Gracl::User.new_from_file( keyfile )
        end
    end

    def repository(name, &block)
        repos << Gracl::Repo.new(name, &block)
    end

    def group(name, &block)
        groups << Gracl::Group.new(name, &block)
    end
end
