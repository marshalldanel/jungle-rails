class User < ActiveRecord::Base
<<<<<<< HEAD
  
=======
>>>>>>> feature/users
  has_many :reviews
  has_secure_password

  validates :email, uniqueness: true
end
