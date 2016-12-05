require 'cachers/base'
require 'cachers/concern'
require 'cachers/railtie'
require 'cachers/version'

module Cachers
  class << self

    def models
      if Rails.configuration.cache_classes == false
        Rails.application.eager_load!
      end
      ActiveRecord::Base.descendants.select do |model|
        model.included_modules.include?(Cachers::Concern) && model.descendants.none?
      end
    end

    %i(cache uncache recache).each do |action|
      define_method action do
        models.each do |model|
          model.find_each do |record|
            puts "Running #{action} on #{model.name} ##{record.id}"
            record.send action
          end
        end
      end
    end

  end
end
