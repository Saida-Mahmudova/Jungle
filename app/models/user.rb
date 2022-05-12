class User < ApplicationRecord
    has_secure_password
    validates_length_of :password, minimum: 4
    validates_uniqueness_of :email, :case_sensitive => false, on: :create
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true

end
def self.authenticate_with_credentials(input_email, input_password)

    @user = User.find_by(email: input_email.strip.downcase)

    if @user && @user.authenticate(input_password)
      @user
    else
      nil
    end

  end

end