class Gracl::Config::Permission::Branch < Gracl::Config::Permission
    attr_accessor :branch

    def initialize(who, branch)
        super(who)
        self.branch = branch
    end

    def implies_write?
        true
    end

    def allow?(repo, ref, oldsha, newsha)
        ref =~ branch
    end

    def describe
        "allow_branch #{branch.inspect} => #{who.inspect}"
    end
end
