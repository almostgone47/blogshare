class User < ActiveRecord::Base

  VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  before_save { self.email = email.downcase }
  validates :email, presence: true, uniqueness: true, length: { minimum: 4, maximum: 50 }, format: { with: VALID_EMAIL }
  validates :password, presence: true, length: { minimum: 4, maximum: 20 }
  validates :user_name, presence: true, uniqueness: true, length: { minimum: 2, maximum: 20 }
  has_secure_password
  has_many :articles, dependent: :destroy
  has_many :authentications, dependent: :destroy

  def self.create_with_auth_and_hash(authentication, auth_hash)
    user = self.create!(
      user_name: auth_hash["info"]["name"],
      email: auth_hash["info"]["email"],
      password: SecureRandom.hex(10)
    )
    user.authentications << authentication
    return user
  end

   # grab google to access google for user data
  def google_token
    x = self.authentications.find_by(provider: 'google_oauth2')
    return x.token unless x.nil?
  end

end
