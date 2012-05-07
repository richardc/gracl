class Gracl::Command::Setup < Gracl::Command
    def execute
        config = Gracl::Config.new(File.expand_path("~/.gracl"))
        if !config.validate
            raise "config fails to validate, not asserting"
        end

        gracl = Gracl.new((File.expand_path("~/.gracl")))
        gracl.install_ssh_config
    end
end
