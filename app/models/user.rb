class User < ActiveRecord::Base
  has_many :bookmarks

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid      = auth.uid
      user.name     = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save
    end
  end

  def friendlist
    friends = []
    facebook.get_connections('me', 'friends').each do |friend|
      friends << User.find_or_create_by(name: friend['name'], uid: friend['id'], provider: :facebook)
    end
    friends
  end

  def facebook
    @facebook ||= Koala::Facebook::API.new(oauth_token)
    block_given? ? yield(@facebook) : @facebook
  rescue Koala::Facebook::APIError => e
    logger.info e.to_s
    nil
  end
end
