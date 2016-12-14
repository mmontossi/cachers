module Cachers
  module Extensions
    module ActiveRecord
      module Base
        extend ActiveSupport::Concern

        module ClassMethods

          def inherited(subclass)
            super
            if subclass.name && File.exist?("#{Rails.root}/app/cachers/#{subclass.name.underscore}_cacher.rb")
              subclass.include Cachers::Concern
            end
          end

        end
      end
    end
  end
end
