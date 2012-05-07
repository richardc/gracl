class Gracl::Command::Install < Gracl::Command
    parameter "ADMIN", "public keyfile of the initial administrator"
    def execute
        gracl = Gracl.new(File.expand_path("~/.gracl"))
        gracl.create_admin_repository(admin)
        gracl.install_ssh_config
    end
end
