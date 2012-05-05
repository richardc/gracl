class Gracl
end

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
end