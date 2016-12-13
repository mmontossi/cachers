module Cachers
  module Concern
    extend ActiveSupport::Concern

    %i(include extend).each do |action|
      send action, Delegation
    end

    included do
      after_commit :cache, on: :create
      after_commit :recache, on: :update
      after_commit :uncache, on: :destroy
    end

    def cacher
      @cacher ||= self.class.cacher.new(self)
    end

    module ClassMethods

      def cacher
        "#{name}Cacher".constantize
      end

    end
  end
end
