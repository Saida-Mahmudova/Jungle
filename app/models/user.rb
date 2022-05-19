class User < ApplicationRecord
  has_secure_password

  validates :first_name, :last_name, :password_confirmation, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 4}, presence: true

   def self.authenticate_with_credentials(email, password)
    email = email.downcase.strip
    @user = User.find_by_email(email)
    if (@user && @user.authenticate(password))
      @user
    else
      nil
    end
  end
end