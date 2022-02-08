require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    before do
      @user = User.new(
        first_name: 'Hisham',
        last_name: 'Abbas',
        email: 'hisham@gmail.com',
        password: '123456',
        password_confirmation: '123456'
      )
    end

    it 'successfully saves a new user when all fields are provided' do
      saved = @user.save
      expect(saved).to be_truthy
    end

    it 'returns an error message when the first_name field is missing' do
      @user.first_name = nil
      saved = @user.save
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it 'returns an error message when the last_name field is missing' do
      @user.last_name = nil
      saved = @user.save
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'returns an error message when the email field is missing' do
      @user.email = nil
      saved = @user.save
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'returns an error message when the password and password_confirmation fields does not match' do
      @user.password_confirmation = '654321'
      saved = @user.save
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'returns an error message when the email has already been used' do
      @newUser = @user.clone
      @newUser.email = 'HISHAM@GMAIL.COM'
      @user.save
      saved = @newUser.save
      expect(@newUser.errors.full_messages).to include('Email has already been taken')
    end

    it 'returns an error message when the provided password length is less than 6 characters' do
      @user.password = '12345'
      @user.password_confirmation = '12345'
      saved = @user.save
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end
  end

  describe '.authenticate_with_credentials' do
    before do
      @user = User.new(
        first_name: 'Hisham',
        last_name: 'Abbas',
        email: 'hisham@gmail.com',
        password: '123456',
        password_confirmation: '123456'
      )
    end

    it 'allows the user to login on successful authentication' do
      @user.save
      authenticated = User.authenticate_with_credentials(@user.email, @user.password)
      expect(authenticated).to eql(@user)
    end

    it 'allows the user to login when provided email with white spaces around' do
      @user.save
      authenticated = User.authenticate_with_credentials('  hisham@gmail.com  ', @user.password)
      expect(authenticated).to eql(@user)
    end

    it 'allows the user to login when provided email with upper/lower case' do
      @user.save
      authenticated = User.authenticate_with_credentials('hIsHam@gMail.com', @user.password)
      expect(authenticated).to eql(@user)
    end

    it 'returns nill when user authentication fails due to wrong email' do
      @user.save
      authenticated = User.authenticate_with_credentials('H@gmail.com', @user.password)
      expect(authenticated).to eql(nil)
    end

    it 'returns nill when user authentication fails due to wrong password' do
      @user.save
      authenticated = User.authenticate_with_credentials(@user.email, 'incorrect')
      expect(authenticated).to eql(nil)
    end
  end
end
