class Gracl::Permission::Write < Gracl::Permission
    def describe
        "writers #{who.inspect}"
    end
end
