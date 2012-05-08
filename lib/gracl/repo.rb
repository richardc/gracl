class Gracl::Repo
    attr_accessor :config
    attr_accessor :name
    attr_accessor :description
    attr_accessor :section
    attr_accessor :acls

    def initialize(name, &block)
        self.config = Gracl::Config.current
        self.name = name
        self.acls = []
        instance_eval &block
    end

    def description(description)
        self.description = description
    end

    def section(section)
        self.section = section
    end

    def readers(*readers)
        self.acls << Gracl::Permission.new(:read, readers)
    end

    def writers(*writers)
        self.acls << Gracl::Permission.new(:write, writers)
    end

    def allow_branch(refspec, *who)
        self.acls << Gracl::Permission.new(:ref, refspec, who)
    end

    def allow_path(pathspec, *who)
        self.acls << Gracl::Permission.new(:path, pathspec, who)
    end
end
