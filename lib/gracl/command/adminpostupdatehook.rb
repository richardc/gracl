class Gracl::Command::AdminPostUpdateHook < Gracl::Command
    def execute
        logger.info { "starting admin-post-update-hook" }

        # TODO/XXX inspect the new config for validness

        POSIX::Spawn::Child.new({ GIT_WORK_TREE => gracl.admin_checkout},
            'git', 'checkout', '-f', '--quiet', 'master')

        gracl.install_ssh_config
        gracl.install_hooks
    end

    def say(*message)
        $stderr.print message, "\n"
    end
end
