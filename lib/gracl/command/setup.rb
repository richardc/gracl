class Gracl::Command::Setup < Gracl::Command
    def execute
        gracl = Gracl.new(config)
        gracl.validate
        gracl.install_ssh_config
    end
end