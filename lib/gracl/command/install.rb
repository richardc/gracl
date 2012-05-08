class Gracl::Command::Install < Gracl::Command
    parameter "ADMIN", "public keyfile of the initial administrator"
    attr_accessor :gracl
    def execute
        self.gracl = Gracl.new
        create_admin_repository
        gracl.install_ssh_config
        gracl.install_hooks
    end

    def create_admin_repository
        if File.directory? gracl.admin_repo
            raise "Already created admin repo, bailing"
        end
        repo = Grit::Repo.init_bare(gracl.admin_repo)
        index = repo.index
        index.add("gracl.conf", initial_config)
        index.add("keydir/admin/admin.pub", IO.read(admin))
        index.commit("Initial creation of gracl-admin")

        Dir.mkdir(gracl.admin_checkout)
        ENV["GIT_WORK_TREE"] = gracl.admin_checkout
        system('git', '--git-dir', gracl.admin_repo, 'checkout', '-f', '--quiet', 'master')
        ENV["GIT_WORK_TREE"] = ""
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
