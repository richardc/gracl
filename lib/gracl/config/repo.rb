class Gracl::Config::Repo
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

    def readers(readers)
        self.acls << Gracl::Config::Permission::Read.new(readers)
    end

    def writers(writers)
        self.acls << Gracl::Config::Permission::Write.new(writers)
    end

    def allow_branch(args)
        args.each do |ref,who|
            self.acls << Gracl::Config::Permission::Branch.new(who, ref)
        end
    end

    def allow_path(args)
        args.each do |path,who|
            self.acls << Gracl::Config::Permission::Path.new(who, path)
        end
    end
end
