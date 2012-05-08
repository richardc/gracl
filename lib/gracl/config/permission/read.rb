class Gracl::Config::Permission::Read < Gracl::Config::Permission
    def describe
        "readers #{who.inspect}"
    end
end
