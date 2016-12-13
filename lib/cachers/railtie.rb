module Cachers
  class Railtie < Rails::Railtie

    config.before_initialize do
      Dir["#{Rails.root}/app/cachers/**/*_cacher.rb"].each do |file|
        load file
      end
    end

    initializer 'cachers.active_record' do
      ActiveSupport.on_load :active_record do
        ::ActiveRecord::Base.include(
          Cachers::Extensions::ActiveRecord::Base
        )
      end
    end

    rake_tasks do
      load 'tasks/cachers.rake'
    end

  end
end
