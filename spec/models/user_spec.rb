require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do

    it 'validates that password is correct' do
      @user = User.new(first_name: 'Saida', last_name: 'M', email: 'test@test.com', password: 'test', password_confirmation: 'qwerty' )
      @user.save

      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'validates that password and/or password_confirmation cannot be empty' do
      @user = User.new(first_name: 'Saida', last_name: 'M', email: 'test@test.com', password: '', password_confirmation: '' )
      @user.save

      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'validates that email is unique' do
      @user1 = User.new(first_name: 'Saida', last_name: 'M', email: 'TEST@test.com', password: 'test', password_confirmation: 'test' )
      @user1.save
      @user2 = User.new(first_name: 'Bumbling', last_name: 'Bob', email: 'test@test.com', password: 'test', password_confirmation: 'test' )
      @user2.save

      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end

    it 'validates that first_name, last_name and email fields are not empty' do
      @user = User.new(first_name: nil, last_name: nil, email: nil, password: 'test', password_confirmation: 'test' )
      @user.save

      expect(@user.errors.full_messages).to include("First name can't be blank")
      expect(@user.errors.full_messages).to include("Last name can't be blank")
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'validates that password created has a minimum character length' do
      @user = User.new(first_name: nil, last_name: nil, email: 'test@test.com', password: 'tes', password_confirmation: 'tes' )
      @user.save
    
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 4 characters)")
    end
  end

  describe '.authenticate_with_credentials' do

    it 'calls the authenticate method and returns the user' do
      @user = User.new(first_name: 'Saida', last_name: 'M', email: 'test@test.com', password: 'test', password_confirmation: 'test' )
      @user.save

      result = User.authenticate_with_credentials('test@test.com', 'test')
      expect(result).to eq @user
    end

    it 'calls the authenticate method and returns nil' do
      @user = User.new(first_name: 'Saida', last_name: 'M', email: 'test@test.com', password: 'test', password_confirmation: 'test' )
      @user.save

      result = User.authenticate_with_credentials('test@test.com', 'some')
      expect(result).to be_nil
    end

    it 'finds by email regardless of blank space' do
      @user = User.new(first_name: 'Saida', last_name: 'M', email: 'test@test.com', password: 'test', password_confirmation: 'test' )
      @user.save

      result = User.authenticate_with_credentials('test@test.com  ', 'test')
      expect(result).to eq @user
    end

    it 'finds by email regardless of case' do
      @user = User.new(first_name: 'Saida', last_name: 'M', email: 'test@test.com', password: 'test', password_confirmation: 'test' )
      @user.save

      result = User.authenticate_with_credentials('TEST@test.com', 'test')
      expect(result).to eq @user
    end

  end
end