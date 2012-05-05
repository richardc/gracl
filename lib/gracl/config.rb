class Gracl
end

class Gracl::Config
    def initialize
        @repos = []
        @@instance = self
    end

    def self.setup(&block)
        @@instance.instance_eval &block
    end

    def repository(name, &block)
        @repos << Gracl::Repo.new(name, &block)
    end
end
