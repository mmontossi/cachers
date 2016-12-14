module Cachers
  module Concern
    extend ActiveSupport::Concern
    include Delegation

    included do
      after_commit :cache, on: :create
      after_commit :recache, on: :update
      after_commit :uncache, on: :destroy
    end

    def cacher
      @cacher ||= self.class.cacher.new(self)
    end

    module ClassMethods
      include Delegation

      def cacher
        "#{name}Cacher".constantize
      end

    end
  end
end
