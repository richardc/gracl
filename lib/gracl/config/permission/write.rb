class Gracl::Config::Permission::Write < Gracl::Config::Permission
    def implies_write?
        true
    end

    def allow?(repo, ref, oldsha, newsha)
        true
    end

    def describe
        "writers #{who.inspect}"
    end
end
