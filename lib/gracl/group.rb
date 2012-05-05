class Gracl::Group
    def initialize(name, &block)
        @name = name
        @members = []
        self.instance_eval(&block)
    end
    
    def members
        @members
    end
end
