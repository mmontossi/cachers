class UserCacher < Cachers::Base

  def cache
    $redis.set key, record.name
  end

  def uncache
    $redis.del key
  end

  private

  def key
    "users/#{record.id}"
  end

end
