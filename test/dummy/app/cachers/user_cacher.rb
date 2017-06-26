class UserCacher < Cachers::Base

  def cache
    set key, record.name
  end

  def uncache
    del key
  end

  private

  def key
    "users/#{record.name.parameterize}"
  end

  class << self

    def cached?(user)
      exists "users/#{user.name.parameterize}"
    end

  end
end
