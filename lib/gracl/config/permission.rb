class Gracl::Config::Permission
    attr_accessor :who

    def initialize(who)
        self.who  = who
    end

    def implies_write?
        false
    end

    def allow?(ref, oldsha, newsha)
        false
    end

    def describe
        inspect
    end
end
