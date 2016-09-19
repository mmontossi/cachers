require 'test_helper'

class TasksTest < ActiveSupport::TestCase

  setup do
    load File.expand_path('../../lib/tasks/cachers.rake', __FILE__)
    Rake::Task.define_task :environment
  end

  test 'tasks' do
    users = %w(mike john).map do |name|
      User.create name: name
    end
    Rake::Task['cachers:cache'].invoke
    users.each do |user|
      assert_equal user.name, $redis.get("users/#{user.id}")
    end

    $redis.flushall
    Rake::Task['cachers:recache'].invoke
    users.each do |user|
      assert_equal user.name, $redis.get("users/#{user.id}")
    end

    Rake::Task['cachers:uncache'].invoke
    assert_equal 0, $redis.keys.size
  end

end
