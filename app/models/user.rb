class User < ApplicationRecord
  has_secure_password
  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, :password_confirmation, length: { minimum: 4 }

def self.authenticate_with_credentials(input_email, input_password)
  user = User.find_by_email(input_email.strip.downcase)
  return nil if input_email.nil?
  return user if user && user.authenticate(input_password)
    nil
  end
end