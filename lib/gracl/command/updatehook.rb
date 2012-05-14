class Gracl::Command::UpdateHook < Gracl::Command
    parameter "REF",     "The branch being updated"
    parameter "OLDSHA",  "The sha1 before"
    parameter "NEWSHA",  "The sha1 after"

    def execute
        user = ENV['GRACL_USER']
        repo = ENV['GRACL_REPO']
        logger.info { "update-hook #{user} #{repo}: #{ref} #{oldsha} #{newsha}" }

        perms = gracl.config.permissions_for(user)[repo]
        perms.each do |permission|
            logger.debug { "testing #{permission.describe}" }
            if permission.allow? ref, oldsha, newsha
                logger.info { "allowed via #{permission.describe}" }
                exit 0
            end
        end
        logger.info { "denying update" }
        say "Denied update"
        exit 1
    end

    def say(*message)
        $stderr.print message, "\n"
    end
end
