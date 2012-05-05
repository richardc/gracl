class Gracl::Command::Dump < Gracl::Command
    def execute
        puts Gracl.new(config).to_yaml
    end
end
