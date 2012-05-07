class Gracl::Command::Setup < Gracl::Command
    def execute
        config = Gracl::Config.new(File.expand_path("~/.gracl"))
        config.validate
        puts config.to_yaml
    end
end
