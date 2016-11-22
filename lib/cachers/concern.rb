module Cachers
  module Concern
    extend ActiveSupport::Concern

    included do
      # NOTE: For some mysterious reason declare them reversed makes tests pass.
      after_commit :uncache, on: :destroy
      after_commit :recache, on: :update
      after_commit :cache, on: :create
    end

    delegate :cache, :recache, :uncache, to: :cacher

  end
end
