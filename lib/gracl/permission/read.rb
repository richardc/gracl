class Gracl::Permission::Read < Gracl::Permission
    def describe
        "readers #{who.inspect}"
    end
end
