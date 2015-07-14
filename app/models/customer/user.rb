class Customer::User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]
  acts_as_paranoid

  def self.from_omniauth(auth)
    user = where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email || ""
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
    end

    user.update(name: auth.info.name) if user.name != auth.info.name

    return user
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"]
        user.provider = data["provider"]
        user.uid = data["uid"]
        user.name = data["info"]["name"]
      end
    end
  end
end
