module Cachers
  module Dsl

    def method_missing(name, *args, &block)
      Cachers.redis.send name, *args, &block
    end

  end
end
