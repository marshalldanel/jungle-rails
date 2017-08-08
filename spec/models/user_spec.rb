require 'rails_helper'

RSpec.describe User, type: :model do
  
  before :each do
    @user = User.create ({
      first_name: 'Bob',
      last_name: 'Bob',
      email: 'bob@bob.com',
      password: '12345678',
      password_confirmation: '12345678'
    })
    @baduser = User.create
  end

  describe 'Validations' do

    describe '#new' do
      it 'should be valid' do
        expect(@user).to be_valid
      end

      it 'should have a first name' do
        expect(@baduser.errors.full_messages).to include("First name can't be blank")
      end

      it 'should have a last name' do
        expect(@baduser.errors.full_messages).to include("Last name can't be blank")
      end

      it 'should have a email' do
        expect(@baduser.errors.full_messages).to include("Email can't be blank")
      end

      it 'should have a unique email' do
        @bademail = User.create email: 'bob@BOB.com'
        expect(@bademail.errors.full_messages).to include("Email has already been taken")
      end

      it 'should have a password' do
        expect(@baduser.errors.full_messages).to include("Password can't be blank")
      end

      it 'should have a matching password' do
        @badpass = User.create ({
          first_name: 'Bill',
          last_name: 'Bill',
          email: 'bill@bill.com',
          password: '87654321',
          password_confirmation: '987654321'
        })
        expect(@badpass).to_not be_valid
      end

      it 'should have min 8 char password' do
        @blankpass = User.create ({
          first_name: 'Joe',
          last_name: 'Joe',
          email: 'joe@joe.com',
          password: '1234',
          password_confirmation: '1234'
        })
        expect(@blankpass).to_not be_valid
      end
    end
  end

  describe '.authenticate_with_credentials' do

    it 'allows authenticated access' do
      user = User.authenticate_with_credentials('bob@bob.com', '12345678')
      expect(user).to eql(@user)
    end

    it 'blocks unauthenticated access'  do
      user = User.authenticate_with_credentials('bill@bill.com', '123456789')
      expect(user).to_not eql(@user)
    end
  end
  
end