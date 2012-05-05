class Gracl
end

class Gracl::Config
end

class Gracl::Config::Repo
    attr_accessor :name
    attr_accessor :description
    attr_accessor :section
    attr_accessor :acls

    def initialize(name, &block)
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
        self.acls << Gracl::Config::Repo::Permission.new(:read, readers)
    end

    def writers(*writers)
        self.acls << Gracl::Config::Repo::Permission.new(:write, writers)
    end

    def group
        { :pies => 1 }
    end

    def allow_branch(refspec, *who)
        self.acls << Gracl::Config::Repo::Permission.new(:ref, refspec, who)
    end

    def allow_path(pathspec, *who)
        self.acls << Gracl::Config::Repo::Permission.new(:path, pathspec, who)
    end
end
