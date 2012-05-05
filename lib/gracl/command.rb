class Gracl::Command < Clamp::Command
    subcommand "shell",   "The shell invoked from SSH", Gracl::Command::Shell
    subcommand "install", "Install Gracl",              Gracl::Command::Install
    subcommand "dump",    "Dump the configuration",     Gracl::Command::Dump
end
