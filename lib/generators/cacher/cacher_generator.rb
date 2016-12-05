require 'rails/generators'

module Cachers
  module Generators
    class CacherGenerator < ::Rails::Generators::NamedBase

      source_root File.expand_path('../templates', __FILE__)

      def create_cacher_file
        template 'cacher.rb', "app/cachers/#{file_name}_cacher.rb"
      end

    end
  end
end
