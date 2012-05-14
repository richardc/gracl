class Gracl::Command < Clamp::Command
    option ["-v", "--verbose"], :flag, "be verbose"

    def gracl
        @gracl ||= Gracl.new
    end

    def logger
        @logger ||= gracl.logger
    end

    subcommand  "shell",
                "The shell invoked from SSH",
                Gracl::Command::Shell
    subcommand  "install",
                "Install Gracl",
                Gracl::Command::Install
    subcommand  "setup",
                "Check configuration, hook hooks, emit ssh",
                Gracl::Command::Setup
    subcommand  "admin-post-update-hook",
                "",
                Gracl::Command::AdminPostUpdateHook
    subcommand  "update-hook",
                "",
                Gracl::Command::UpdateHook
    subcommand  "dump",
                "Dump the configuration",
                Gracl::Command::Dump
end
