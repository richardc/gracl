class Gracl::Command::Setup < Gracl::Command
    def execute
        gracl = Gracl.new
        config = gracl.config
        puts config.to_yaml if verbose?
        if !config.validate
            raise "config fails to validate, not asserting"
        end
        gracl.install_hooks
        gracl.install_ssh_config
    end
end
