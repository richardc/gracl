class Gracl::Config::Permission::Path < Gracl::Config::Permission
    attr_accessor :path

    def initialize(who, path)
        super(who)
        self.path = path
    end

    def describe
        "allow_path #{path.inspect} => #{who.inspect}"
    end
end
