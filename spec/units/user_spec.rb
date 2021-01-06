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

  describe '.find' do
    it 'returns the user' do
      user = User.create(email: 'test@example.com', password: 'test')

      result = User.find(id: user.id)
      expect(result.id).to eq user.id
      expect(result.email).to eq user.email
    end
    it 'returns nil if no ID given' do
      expect(User.find(id: nil)).to eq nil
    end
  end
end
