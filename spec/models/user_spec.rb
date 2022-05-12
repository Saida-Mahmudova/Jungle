require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    it 'validates that password and password_confirm contain the same values.' do
      @user = User.new(first_name: 'Sassy', last_name: 'Sally', email: 'test@a.ca', password: 'test', password_confirmation: 'qwerty' )
      @user.save

      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'validates that password and password_confirm cannot be blank.' do
      @user = User.new(first_name: 'Sassy', last_name: 'Sally', email: 'test@a.ca', password: '', password_confirmation: '' )
      @user.save

      expect(@user.errors.full_messages).to include("Password can't be blank")

    end

    it 'validates that email is unique' do
      @user1 = User.new(first_name: 'Sassy', last_name: 'Sally', email: 'test@a.ca', password: 'test', password_confirmation: 'test' )
      @user1.save

      @user2 = User.new(first_name: 'Bumbling', last_name: 'Bob', email: 'test@a.ca', password: 'test', password_confirmation: 'test' )
      @user2.save

      expect(@user2.errors.full_messages).to include("Email has already been taken")

    end

    it 'validates that first_name, last_name and email are present' do
@user = User.new(first_name: nil, last_name: 'Sally', email: 'test@a.ca', password: 'test', password_confirmation: 'test' )
      @user = User.new(first_name: nil, last_name: nil, email: nil, password: 'test', password_confirmation: 'test' )
      @user.save

      expect(@user.errors.full_messages).to include("First name can't be blank")

      expect(@user.errors.full_messages).to include("Last name can't be blank")
      expect(@user.errors.full_messages).to include("Email can't be blank")

    end

    it 'validates that password created has a minimum character length' do

   @user = User.new(first_name: nil, last_name: nil, email: 'test@a.ca', password: 'te', password_confirmation: 'te' )
      @user.save

    
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 4 characters)")

    end



  end

  describe '.authenticate_with_credentials' do
    it 'calls the authenticate method and returns the user instance' do
      @user = User.new(first_name: 'Sassy', last_name: 'Sally', email: 'test@x.ca', password: 'test', password_confirmation: 'test' )
      @user.save

      result = User.authenticate_with_credentials('test@x.ca', 'test')

      expect(result).to eq @user

    end
      it 'calls the authenticate method and returns nil' do
      @user = User.new(first_name: 'Sassy', last_name: 'Sally', email: 'test@x.ca', password: 'test', password_confirmation: 'test' )
      @user.save

      result = User.authenticate_with_credentials('test@x.ca', 'blah')

      expect(result).to be_nil

    end
    it 'should successfully fetch the by email regardless of whitespace' do
      @user = User.new(first_name: 'Sassy', last_name: 'Sally', email: 'test@x.ca', password: 'test', password_confirmation: 'test' )
      @user.save

      result = User.authenticate_with_credentials('  test@x.ca  ', 'test')

      expect(result).to be_a_kind_of User

    end

    it 'should successfully fetch the by email regardless of case' do
      @user = User.new(first_name: 'Sassy', last_name: 'Sally', email: 'test@x.ca', password: 'test', password_confirmation: 'test' )
      @user.save

      result = User.authenticate_with_credentials('TEST@x.ca', 'test')

      expect(result).to be_a_kind_of User

    end

  end

end