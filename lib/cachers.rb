require 'cachers/extensions/active_record/base'
require 'cachers/dsl'
require 'cachers/base'
require 'cachers/delegation'
require 'cachers/concern'
require 'cachers/railtie'
require 'cachers/version'

module Cachers
  class << self

    def redis
      @redis ||= begin
        require 'redis'
        Redis.new YAML.load_file("#{Rails.root}/config/redis.yml")[Rails.env]
      end
    end

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
            record.send action
          end
        end
      end
    end

  end
end
