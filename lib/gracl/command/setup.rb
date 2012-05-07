class Gracl::Command::Setup < Gracl::Command
    def execute
        gracl = Gracl.new(config)
        gracl.config.validate
        gracl.install_new_config
        gracl.install_ssh_config
    end
end
