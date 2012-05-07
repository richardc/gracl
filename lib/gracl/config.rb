class Gracl::Config
    attr_accessor :repos, :users, :groups, :directory
    def initialize(directory = ".")
        self.directory = directory
        self.repos = []
        self.users = []
        self.groups = []

        # used in Gracl::Config.setup
        @@current = self
        Dir.chdir(directory) do
            load_users
            load "gracl.conf"
        end
    end

    def self.setup(&block)
        @@current.instance_eval &block
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

    def validate
    end
end
