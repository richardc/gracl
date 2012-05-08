class Gracl::Permission
    attr_accessor :who

    def initialize(who)
        self.who  = who
    end

    def describe
    end
end
