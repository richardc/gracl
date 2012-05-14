class Gracl::Config::Permission::Branch < Gracl::Config::Permission
    attr_accessor :branch

    def initialize(who, branch)
        super(who)
        self.branch = branch
    end

    def implies_write?
        true
    end

    def allow?(ref, oldsha, newsha)
        if ref !~ /^refs\/heads\/(.*)/
            return false
        end
        head = $1
        head =~ branch
    end

    def describe
        "allow_branch #{branch.inspect} => #{who.inspect}"
    end
end
