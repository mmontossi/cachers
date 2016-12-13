require 'test_helper'

class TaskTest < ActiveSupport::TestCase

  setup do
    load File.expand_path('../../lib/tasks/cachers.rake', __FILE__)
    Rake::Task.define_task :environment
  end

  test 'all' do
    users = %w(mike john).map do |name|
      User.create name: name
    end
    silence_stream(STDOUT) do
      Rake::Task['cachers:cache'].invoke
    end
    users.each do |user|
      assert_equal user.id, client.get("users/#{user.name}").to_i
    end

    client.flushall
    silence_stream(STDOUT) do
      Rake::Task['cachers:recache'].invoke
    end
    users.each do |user|
      assert_equal user.id, client.get("users/#{user.name}").to_i
    end

    silence_stream(STDOUT) do
      Rake::Task['cachers:uncache'].invoke
    end
    assert_equal 0, client.keys.size
  end

end
