class Gracl
end

class Gracl::Permission
    attr_accessor :what
    attr_accessor :who
    
    def initialize(what = :write, *who)
        self.what = what
        self.who  = who
    end
end
