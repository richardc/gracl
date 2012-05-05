class Gracl::Command::Shell < Gracl::Command
    option "--user", "USER", "The user to act as"

    def execute
        ssh_command = ENV["SSH_ORIGINAL_COMMAND"]
        puts "Hello #{user}, you wanted to do #{ssh_command}"
    end
end
