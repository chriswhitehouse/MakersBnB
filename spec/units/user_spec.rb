require 'user'
require "./database_connection_setup"

describe User do

  describe '.create' do
    it 'Inserts a new user into the user table and returns a user object' do
      result = User.create(email: 'test@example.com', password: 'test')

      persisted_data = persisted_data_retrieve(table: 'users', id: result.id)

      expect(result).to be_a User
      expect(result.id).to eq persisted_data['id']
      expect(result.email).to eq 'test@example.com'
    end

    it 'It hashes the password using bcrypt' do
      expect(BCrypt::Password).to receive(:create).with('test')

      User.create(email: 'test@example.com', password: 'test')
    end
  end


end
