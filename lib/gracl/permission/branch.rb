class Gracl::Permission::Branch < Gracl::Permission
    attr_accessor :branch

    def initialize(who, branch)
        super(who)
        self.branch = branch
    end
end
