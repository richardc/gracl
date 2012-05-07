class Gracl::Command < Clamp::Command
    option ["-v", "--verbose"], :flag, "be verbose" do
        Grit.debug = true
    end
    option ["-c", "--config"], "CONFIG", "configuration directory", :default => "."
    subcommand "shell",   "The shell invoked from SSH", Gracl::Command::Shell
    subcommand "install", "Install Gracl",              Gracl::Command::Install
    subcommand "setup",   "Check configuration, emit ssh", Gracl::Command::Setup
    subcommand "dump",    "Dump the configuration",     Gracl::Command::Dump
end
