class Gracl::Command::Install < Clamp::Command
    def execute
        make_a_repo
        put_sample_config
        validate
        run_hooks
    end
end
