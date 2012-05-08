class Gracl::Permission::Path < Gracl::Permission
    attr_accessor :path

    def initialize(who, path)
        super(who)
        self.path = path
    end

    def describe
        "allow_path #{path.inspect} => #{who.inspect}"
    end
end
