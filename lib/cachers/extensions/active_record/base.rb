module Cachers
  module Extensions
    module ActiveRecord
      module Base
        extend ActiveSupport::Concern

        module ClassMethods

          def inherited(subclass)
            if subclass.name && File.exist?("#{Rails.root}/app/cachers/#{subclass.name.underscore}_cacher.rb")
              subclass.include Cachers::Concern
            end
            super
          end

        end
      end
    end
  end
end
