class Gracl::Command::UpdateHook < Gracl::Command
    def execute
        say "In update hook"
        # XXX inspect commit to see if we allow updates to this branch/path
        # This is where we can reject commits based on permissions
    end

    def say(*message)
        $stderr.print message, "\n"
    end
end
