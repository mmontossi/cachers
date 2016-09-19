module Cachers
  class Railtie < Rails::Railtie

    initializer :cachers do
      Dir[Rails.root.join('app/cachers/*')].each { |file| load file }
    end

  end
end
