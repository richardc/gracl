class Gracl::Config::Group
    attr_accessor :name

    def initialize(name, &block)
        self.name = name
        self.instance_eval(&block)
    end

    def members(*members)
        members.each do |member|
            Gracl::Config.current.user(member).groups << name
        end
    end
end
