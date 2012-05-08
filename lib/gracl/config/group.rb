class Gracl::Config::Group
    attr_accessor :config
    attr_accessor :name

    def initialize(name, &block)
        self.config = Gracl::Config.current
        self.name = name
        self.instance_eval(&block)
    end

    def members(*members)
        members.each do |member|
            config.user(member).groups << name
        end
    end
end
