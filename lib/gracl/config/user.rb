class Gracl::Config::User
    attr_accessor :name
    attr_accessor :keyfile
    attr_accessor :groups

    def initialize(name, keyfile)
        self.name = name
        self.keyfile = File.expand_path(keyfile)
        self.groups  = (keyfile.split /\//)[1..-2]
    end

    def self.new_from_file(filename)
        self.new(File.basename(filename, '.pub'), filename)
    end

    def keys
        File.open(keyfile).lines
    end

    def allowed(operation, repository)
        true
    end
end
