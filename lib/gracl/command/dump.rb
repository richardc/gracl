class Gracl::Command::Dump < Gracl::Command
    parameter "CONFIG", "configuration directory"
    def execute
        puts Gracl::Config.new(config).to_yaml
    end
end
