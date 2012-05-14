class Gracl::Config::Permission::Path < Gracl::Config::Permission
    attr_accessor :path

    def initialize(who, path)
        super(who)
        self.path = path
    end

    def implies_write?
        true
    end

    def allow?(ref, oldsha, newsha)
        empty_tree = '4b825dc642cb6eb9a060e54bf8d69288fbee4904'
        oldtree = oldsha == "0" * 40 ? empty_tree : oldsha
        newtree = newsha == "0" * 40 ? empty_tree : newsha

        diff = POSIX::Spawn::Child.new('git', 'diff', '--name-only', oldtree, newtree)
        changed = diff.out.split(/\n/)
        changed.each do |file|
            if !matches? "/#{file}"
                # XXX log file matched doesn't equal path
                return false
            end
        end

        true
    end

    def matches?(file)
        case path.class
        when String
            File.fnmatch(file, path)
        when Regexp
            file =~ path
        else
            # XXX log invalid path
            false
        end
    end

    def describe
        "allow_path #{path.inspect} => #{who.inspect}"
    end
end
