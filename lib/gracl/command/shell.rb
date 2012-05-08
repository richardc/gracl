require 'shellwords'

class Gracl::Command::Shell < Gracl::Command
    option "--user", "USER", "The user to act as"

    def execute
        ssh_command = ENV['SSH_ORIGINAL_COMMAND'] || ''
        cmd = Shellwords::shellwords(ssh_command)

        say "Hello #{user}, you want to: #{cmd.inspect}"
        (command, repo) = cmd
        if git_commands.include?(command)
            say "Checking if that's OK"
            check_allowed(user, command, repo)

            say "Sure, why not"
            Dir.chdir(gracl.repositories)

            ENV["PATH"] = "/bin:/usr/bin:/usr/local/bin"
            exec("git", "shell", "-c", ssh_command)
            deny "Wasn't able to run git"
        end

        # Tell them what they have access to
        gracl.config.permissions_for(user).sort.each do |repo,perms|
            say "repository '#{repo}' do"
            perms.each do |perm|
                say "    #{perm.describe}"
            end
            say "end"
            say
        end
    end

    def say(*message)
        $stderr.print message, "\r\n"
    end

    def git_commands
        [ 'git-receive-pack', # push
          'git-upload-pack',  # pull
        ]
    end

    def deny(*message)
        say "DENY: ", message
        exit 1
    end

    def check_allowed(username, command, repository)
        repo = gracl.config.repo(repository) or
            deny "Repository #{repository} unconfigured"
        user = gracl.config.user(username) or
            deny "User #{username} unconfigured"
        user.allowed(command, repo) or
            deny "User not allowed to do that"
    end
end
