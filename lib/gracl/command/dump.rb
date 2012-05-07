class Gracl::Command::Dump < Gracl::Command
    def execute
        puts Gracl.new(config_directory).config.to_yaml
    end
end
