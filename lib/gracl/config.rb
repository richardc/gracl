class Gracl
end

class Gracl::Config
    def initialize
        @repos = []
        @users = []
        @groups = []
        @@instance = self
        load_users
    end

    def self.setup(&block)
        @@instance.instance_eval &block
    end

    def load_users
        Dir["keydir/**/*.pub"].each do |keyfile|
            @users << Gracl::User.new_from_file( keyfile )
        end
    end

    def repository(name, &block)
        @repos << Gracl::Repo.new(name, &block)
    end

    def group(name, &block)
        @groups << Gracl::Group.new(name, &block)
    end
end
