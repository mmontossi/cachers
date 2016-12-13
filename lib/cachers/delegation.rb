module Cachers
  module Delegation

    def respond_to_missing?(name, private=false)
      cacher.respond_to?(name) || super
    end

    def method_missing(name, *args, &block)
      if cacher.respond_to?(name)
        cacher.send name, *args, &block
      else
        super
      end
    end

  end
end
