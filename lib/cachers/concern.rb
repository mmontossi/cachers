module Cachers
  module Concern
    extend ActiveSupport::Concern

    included do
      after_commit :cache, on: :create
      after_commit :recache, on: :update
      after_commit :uncache, on: :destroy
    end

    delegate :cache, :recache, :uncache, to: :cacher

  end
end
