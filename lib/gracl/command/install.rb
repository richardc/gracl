class Gracl::Command::Install < Gracl::Command
    parameter "ADMIN", "public keyfile of the initial administrator"
    def execute
        create_admin_repository
        gracl.install_ssh_config
        gracl.install_hooks
    end

    def create_admin_repository
        if File.directory? gracl.admin_repo
            raise "Already created admin repo, bailing"
        end

        if File.directory? gracl.admin_checkout
            raise "Already created admin checkout, bailing"
        end

        POSIX::Spawn::Child.new('git', 'init', '--quiet', '--bare', gracl.admin_repo)
        Dir.mkdir(gracl.admin_checkout)

        admin_key = IO.read(admin)
        Dir.chdir(gracl.admin_checkout) do
            Dir.mkdir('logs') # can't call logger till after here
            Dir.mkdir('keydir')
            Dir.mkdir('keydir/admin')
            File.open('keydir/admin/admin.pub', "w") do |file|
                file.write(admin_key)
            end
            File.open('gracl.conf', "w") do |file|
                file.write(initial_config)
            end

            POSIX::Spawn::Child.new({
                GIT_DIR => gracl.admin_repo,
                GIT_WORK_TREE => "." },
                'git', 'add', '.')

            POSIX::Spawn::Child.new({
                GIT_DIR => gracl.admin_repo,
                GIT_WORK_TREE => "." },
                'git', 'commit', '--quiet', '-m', "Initial creation of gracl-admin")
        end
        logger.info { 'created initial config' }
    end

    def initial_config
'''
Gracl::Config.setup do
    repository "gracl-admin" do
        writers   "admin"
    end
end
'''
    end

end
