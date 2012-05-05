class Gracl::Command < Clamp::Command
    option ["-v", "--verbose"], :flag, "be verbose"
    option ["-c", "--config"], "CONFIG", "configuration file to parse", :default => "gracl.conf"
    subcommand "shell",   "The shell invoked from SSH", Gracl::Command::Shell
    subcommand "install", "Install Gracl",              Gracl::Command::Install
    subcommand "dump",    "Dump the configuration",     Gracl::Command::Dump
end
