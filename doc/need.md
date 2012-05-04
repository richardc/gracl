What I need.
============

gitosis/gitolite equivalent, SSH git manager

Needs to allow for more fine-grained access control than gitosis, in a more
readable way than gitolite does

Learn me some ruby

Should be able to end up with a DSL like vagrant, to declare the acls for a
set of repositories

Needs to run OK with 200 repositories, 200 users

Writing out all the repositories would be silly

Maybe something like:

gracl-admin/Gracl

    Gracl::Config.new do |gracl|
        gracl.add_repo("example") do |repo|
            repo.name = "Example Repository"
            repo.cgit.section = "Examples"
            repo.writers << "richardc"
            repo.readers << all
        end
        
        # This repository does somwthing more complex with the permissions.

        gracl.add_repo("second") do |repo|
            repo.name = "Second example repo"
            repo.cgit.section = "Examples"
            
            # Admin group controls master branch
            repo.permit do |access|
                access.refspec = /master/
                access.group = "Admin"
            end
            
            # Developers group can modify any non-master branch
            repo.permit do |access|
                access.refspec = !/master/
                access.group = "Developers"
            end
            
            # Developers and QA groups can make any change that just touches
            # the docs subdirectory
            repo.permit do |access|
                access.path  = '/docs/'
                access.group << "Developers"
                access.group << "QA"
            end
        end
    end


Only possibly more tersely like the facter DSL thingy

    Gracl::Config.new do
        repository "example" do
            description "Example Repository"
            section     "Example"
            readers     "richardc"
            writers     Group["all"]
        end
        
        repository "second" do
            description "Second example"
            section     "Example"
            allow_branch  /master/, :to => Group["Admin"]
            allow_branch !/master/, :to => Group["Developers"]
            allow_path   '/docs/',  :to => [Group["Developers"], Group["QA"]]
        end
    end

