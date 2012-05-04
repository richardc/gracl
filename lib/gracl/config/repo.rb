class Gracl
end

class Gracl::Config
end

class Gracl::Config::Repo
    attr_accessor :name
    attr_accessor :description
    attr_accessor :section

    def initialize(name, &block)
        self.name = name
        instance_eval &block
    end

    def description(description)
        self.description = description
    end

    def section(section)
        self.section = section
    end

    def readers(*readers)
    end

    def writers(*writers)
    end

    def group
        { :pies => 1 }
    end

    def allow_branch(refspec, *who)
    end

    def allow_path(pathspec, *who)
    end
end
