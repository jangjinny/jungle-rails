require 'rails_helper'

RSpec.describe Product, type: :model do
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
    @user2 = User.create(first_name: 'Phoebe', last_name: 'Buffay', email: 'EMAIL@EMAIL.com', password: 'password', password_confirmation: 'password')

    expect(@user2).not_to be_valid
    @user2.errors.full_messages
  end
  end
end

# It must be created with a password and password_confirmation fields
# These need to match so you should have an example for where they are not the same
# These are required when creating the model so you should also have an example for this
# Emails must be unique (not case sensitive; for example, TEST@TEST.com should not be allowed if test@test.COM is in the database)
# Email, first name, and last name should also be required
