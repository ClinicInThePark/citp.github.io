class User < ActiveRecord::Base
  #actions to happen first
  before_create :create_remember_token
  before_save { self.email = email.downcase }
 
 #relationships to other database tables
 has_many :posts, dependent: :destroy #destroys user data when user account 
                                       # is deleted

#validation for forms 
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }

  
#Create session tokens  for signin/signout for authentication and safe login

  	def User.new_remember_token 
  		SecureRandom.urlsafe_base64
  	end 

  	def User.digest(token)
  		Digest::SHA1.hexdigest(token.to_s)
  	end
    
#helper methods for session token authentication. 
  	private

  		def create_remember_token
  			self.remember_token = User.digest(User.new_remember_token)
  		end

end