class User < ActiveRecord::Base
  has_many :reviews
  has_secure_password

  validates :password, length: { minimum: 8 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :last_name, presence: true
  validates :first_name, presence: true

  def self.authenticate_with_credentials(email, password)
    # @user ||= User.find(email, password) if [:email, :password]
    
    user = User.where(["email = ?", email.strip.downcase]).first
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end
end
