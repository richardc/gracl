class Gracl::Config::Permission::Write < Gracl::Config::Permission
    def implies_write?
        true
    end

    def describe
        "writers #{who.inspect}"
    end
end
