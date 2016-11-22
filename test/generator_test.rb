require 'test_helper'
require 'rails/generators'
require 'generators/cacher_generator'

class GeneratorsTest < Rails::Generators::TestCase
  destination Rails.root.join('tmp')

  teardown do
    FileUtils.rm_rf destination_root
  end

  test 'cacher' do
    self.class.tests Cachers::Generators::CacherGenerator
    run_generator %w(user)
    assert_file 'app/cachers/user_cacher.rb'
  end

end
