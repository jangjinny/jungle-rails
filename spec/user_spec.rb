require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
  it 'creates a new user' do
    @user = User.new(first_name: 'Monica', last_name: 'Geller', email: 'email@email.com', password: 'password', password_confirmation: 'password')
    expect(@user).to be_valid
    @user.errors.full_messages
  end
  it 'is not valid if the password and password confirmation does not match' do
    @user = User.new(first_name: 'Rachel', last_name: 'Green', email: 'email@email.com', password: 'different', password_confirmation: 'password')
    expect(@user).not_to be_valid
    @user.errors.full_messages
  end
  it 'is not valid without a unique email' do
    @user1 = User.create(first_name: 'Phoebe', last_name: 'Buffay', email: 'email@email.com', password: 'password', password_confirmation: 'password')
    @user2 = User.create(first_name: 'Phoebe', last_name: 'Buffay', email: 'EMAIL@email.com', password: 'password', password_confirmation: 'password')
    expect(@user2).not_to be_valid
    @user2.errors.full_messages
  end
  it 'is not valid without an email' do
    @user = User.new(first_name: 'Rachel', last_name: 'Green', email: nil, password: 'different', password_confirmation: 'password')
    expect(@user).not_to be_valid
    @user.errors.full_messages
  end
  it 'is not valid without a first_name' do
    @user = User.new(first_name: nil, last_name: 'Green', email: 'email@email.com', password: 'different', password_confirmation: 'password')
    expect(@user).not_to be_valid
    @user.errors.full_messages
  end
  it 'is not valid without a last name' do
    @user = User.new(first_name: 'Rachel', last_name: nil, email: 'email@email.com', password: 'different', password_confirmation: 'password')
    expect(@user).not_to be_valid
    @user.errors.full_messages
  end
  it 'is not valid when the password is shorter than 5 characters' do
    @user = User.new(first_name: 'Rachel', last_name: 'Green', email: 'email@email.com', password: 'four', password_confirmation: 'four')
    expect(@user).not_to be_valid
    @user.errors.full_messages
  end
  end

  describe '.authenticate_with_credentials' do
  it 'authenticates user with correct credentials' do
    @user = User.create(first_name: 'Chandler', last_name: 'Bing', email:'friends@friends.com', password: 'friends11', password_confirmation: 'friends11')
    @login = User.authenticate_with_credentials('friends@friends.com', 'friends11')
    expect(@login).to eq @user
    @login.errors.full_messages
  end
  it 'does not authenticate user with incorrect password' do
    @user = User.create(first_name: 'Chandler', last_name: 'Bing', email:'friends@friends.com', password: 'friends11', password_confirmation: 'friends11')
    @login = User.authenticate_with_credentials('friends@friends.com', 'friends00')
    expect(@login).to be nil
  end
  it 'does not authenticate user with incorrect email' do
    @user = User.create(first_name: 'Chandler', last_name: 'Bing', email:'friends@friends.com', password: 'friends11', password_confirmation: 'friends11')
    @login = User.authenticate_with_credentials('test@test.com', 'friends11')
    expect(@login).to be nil
  end
  it 'authenticates user with spaces before correct email' do
    @user = User.create(first_name: 'Chandler', last_name: 'Bing', email:'friends@friends.com', password: 'friends11', password_confirmation: 'friends11')
    @login = User.authenticate_with_credentials('   friends@friends.com   ', 'friends11')
    expect(@login).to eq @user
    @login.errors.full_messages
  end
  it 'authenticates user with different case for correct email' do 
    @user = User.create(first_name: 'Chandler', last_name: 'Bing', email:'friends@friends.com', password: 'friends11', password_confirmation: 'friends11')
    @login = User.authenticate_with_credentials('FRIENDS@friends.COM', 'friends11')
    expect(@login).to eq @user
    @login.errors.full_messages
  end
  end
end