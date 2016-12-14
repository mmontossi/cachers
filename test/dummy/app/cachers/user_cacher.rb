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

  class << self

    def cached?(user) 
      exists "users/#{user.name}"
    end

  end
end
