require 'test_helper'

class ModelTest < ActiveSupport::TestCase

  test 'callbacks' do
    user = User.create(name: 'Mike')
    key = 'users/mike'
    assert_equal user.name, redis.get(key)

    user.update name: 'John'
    old_key = key
    key = 'users/john'
    assert_nil redis.get(old_key)
    assert_equal user.name, redis.get(key)

    user.destroy
    assert_nil redis.get(old_key)
    assert_nil redis.get(key)
  end

  test 'singleton' do
    user = User.new(name: 'Gregory')
    assert_not User.cached?(user)

    user.save!
    assert User.cached?(user)
  end

end
