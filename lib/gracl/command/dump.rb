class Gracl::Command::Dump < Clamp::Command
    def execute
        puts Gracl.new.to_yaml
    end
end
