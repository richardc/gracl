class Gracl::Command::Setup < Gracl::Command
    def execute
        logger.info { "starting admin-post-update-hook" }

        config = gracl.config
        if !config.validate
            raise "config fails to validate, not asserting"
        end
        gracl.install_hooks
        gracl.install_ssh_config
    end
end
