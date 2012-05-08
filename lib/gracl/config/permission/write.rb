class Gracl::Config::Permission::Write < Gracl::Config::Permission
    def describe
        "writers #{who.inspect}"
    end
end
