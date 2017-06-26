require 'test_helper'

class TaskTest < ActiveSupport::TestCase

  setup do
    load File.expand_path('../../lib/tasks/cachers.rake', __FILE__)
    Rake::Task.define_task :environment
  end

  test 'all' do
    %w(Mike John).each do |name|
      User.create name: name
    end

    Rake::Task['cachers:uncache'].invoke
    assert_equal 0, redis.keys.size

    Rake::Task['cachers:cache'].invoke
    assert_equal 2, redis.keys.size

    Rake::Task['cachers:recache'].invoke
    assert_equal 2, redis.keys.size
  end

end
