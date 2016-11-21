module Cachers
  class Railtie < Rails::Railtie

    initializer :cachers do
      Dir[Rails.root.join('app/cachers/*')].each { |file| load file }
    end

    rake_tasks do
      load 'tasks/cachers.rake'
    end

  end
end
