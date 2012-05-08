class Gracl::Group
    attr_accessor :name
    attr_accessor :config
    def initialize(name, &block)
        self.config = Gracl::Config.current
        self.name = name
        @members = []
        self.instance_eval(&block)
    end
    
    def members
        @members
    end
end
