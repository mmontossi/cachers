module Cachers
  class Railtie < Rails::Railtie

    config.after_initialize do
      Dir[Rails.root.join('app/cachers/*')].each do |file|
        load file
      end
    end

    rake_tasks do
      load 'tasks/cachers.rake'
    end

  end
end
