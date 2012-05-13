require 'shellwords'

class Gracl::Command::Shell < Gracl::Command
    option "--user", "USER", "The user to act as"

    def execute
        ssh_command = ENV['SSH_ORIGINAL_COMMAND'] || ''
        cmd = Shellwords::shellwords(ssh_command)

        say "Hello #{user}, you want to: #{cmd.inspect}"
        (command, repo) = cmd
        if git_commands.include?(command)
            check_allowed(user, command, repo)

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

    def git_write_commands
        [ 'git-receive-pack' ]
    end

    def git_read_commands
        [ 'git-upload-pack', 'git-upload-archive' ]
    end

    def git_commands
        [ git_write_commands, git_read_commands ].flatten
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

        perms = gracl.config.permissions_for(username)
        if !perms.include? repository
            deny "User #{username} has no access to #{repository}"
        end

        if git_read_commands.include? command
            return true # any permission implies_read (for now)
        end

        perms[repository].each do |permission|
            if permission.implies_write?
                # XXX log which permission allows access
                return true
            end
        end

        deny "User #{username} has no write permission to #{repository}"
    end
end
