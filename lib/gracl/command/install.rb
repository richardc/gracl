class Gracl::Command::Install < Gracl::Command
    parameter "ADMIN", "public keyfile of the initial administrator"
    def execute
        gracl = Gracl.new(config)
        gracl.create_admin_repository(admin)
        #gracl.install_ssh_config
    end
end
