class UserCacher < Cachers::Base

  def cache
    $redis.set key, record.id
  end

  def uncache
    $redis.del key
  end

  private

  def key
    "users/#{record.name}"
  end

end
