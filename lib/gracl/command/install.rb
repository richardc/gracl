class Gracl::Command::Install < Gracl::Command
    parameter "ADMIN", "public keyfile of the initial administrator"
    attr_accessor :gracl
    def execute
        self.gracl = Gracl.new
        create_admin_repository
        gracl.install_ssh_config
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

        system('git', 'clone', gracl.admin_repo, gracl.admin_checkout)
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
