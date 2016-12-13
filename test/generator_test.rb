require 'test_helper'
require 'rails/generators'
require 'generators/cachers/cacher/cacher_generator'
require 'generators/cachers/install/install_generator'

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

  test 'install' do
    self.class.tests Cachers::Generators::InstallGenerator
    run_generator
    assert_file 'config/redis.yml'
  end

end
