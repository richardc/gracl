class Gracl::Command::UpdateHook < Gracl::Command
    parameter "REF",     "The branch being updated"
    parameter "OLDSHA",  "The sha1 before"
    parameter "NEWSHA",  "The sha1 after"
    def execute
        user = ENV['GRACL_USER']
        repo = ENV['GRACL_REPO']
        say "Hello again, #{user} operating on #{repo}"
        say "Updating #{ref} from #{oldsha} to #{newsha}"

        perms = gracl.config.permissions_for(user)[repo]
        perms.each do |permission|
            if permission.allow? repo, ref, oldsha, newsha
                say "Allowed via #{permission.describe}"
                exit 0
            end
        end
        deny "Denied update"
    end

    def say(*message)
        $stderr.print message, "\n"
    end

    def deny (*message)
        say message
        exit 1
    end
end
