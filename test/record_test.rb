require 'test_helper'

class RecordTest < ActiveSupport::TestCase

  test 'callbacks' do
    user = User.create(name: 'mike')
    user.cache
    key = "users/#{user.id}"
    assert_equal 'mike', $redis.get(key)

    user.update name: 'john'
    user.recache
    assert_equal 'john', $redis.get(key)

    user.destroy
    user.uncache
    assert_nil $redis.get(key)
  end

end
