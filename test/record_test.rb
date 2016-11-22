require 'test_helper'

class RecordTest < ActiveSupport::TestCase

  test 'callbacks' do
    user = User.create(name: 'mike')
    user.run_callbacks :commit
    key = "users/#{user.id}"
    assert_equal 'mike', $redis.get(key)

    user.update name: 'john'
    user.run_callbacks :commit
    assert_equal 'john', $redis.get(key)

    user.destroy
    user.run_callbacks :commit
    assert_nil $redis.get(key)
  end

end
