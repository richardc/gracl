class Gracl::Config
    attr_accessor :directory
    attr_accessor :users
    attr_accessor :groups
    attr_accessor :repos

    def initialize(directory = ".")
        self.directory = directory
        self.users = []
        self.groups = []
        self.repos = []

        # used in Gracl::Config.setup
        @@current = self
        Dir.chdir(directory) do
            load_users
            load "gracl.conf"
        end
    end

    def self.current
        @@current
    end

    def self.setup(&block)
        self.current.instance_eval &block
    end

    def load_users
        Dir["keydir/**/*.pub"].each do |keyfile|
            users << Gracl::User.new_from_file(keyfile)
        end
    end

    def repository(name, &block)
        repos << Gracl::Repo.new(name, &block)
    end

    def group(name, &block)
        groups << Gracl::Group.new(name, &block)
    end

    def validate
        true
    end

    def user(name)
        users.find { |u| u.name == name }
    end

    def repo(name)
        repos.find { |r| r.name == name }
    end
end
