module Cachers
  class Railtie < Rails::Railtie

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
