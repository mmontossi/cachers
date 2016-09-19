require 'test_helper'
require 'rails/generators'
require 'generators/cachers/cacher_generator'

class GeneratorsTest < Rails::Generators::TestCase

  tests Cachers::Generators::CacherGenerator
  destination Rails.root.join('tmp')

  teardown do
    FileUtils.rm_rf destination_root
  end

  test 'file generation' do
    run_generator %w(user)
    assert_file 'app/cachers/user_cacher.rb'
  end

end
