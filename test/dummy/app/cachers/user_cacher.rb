class UserCacher < Cachers::Base

  def cache
    set key, record.id
  end

  def uncache
    del key
  end

  private

  def key
    "users/#{record.name}"
  end

end
