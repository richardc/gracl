class Gracl::User
    attr_accessor :name
    attr_accessor :keyfile

    def initialize(name, keyfile)
        self.name = name
        self.keyfile = keyfile
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
