require 'bcrypt'

class User

  def self.create(email:, password:)
    encrypted_password = BCrypt::Password.create(password)
    result = DatabaseConnection.query("INSERT INTO users (email, password) VALUES ('#{email}', '#{encrypted_password}')RETURNING id, email, password;").first
    User.new(id: result['id'],email: result['email'],password: result['password'])
  end

  attr_reader :id, :email, :password


  def initialize(id:, email:, password:)
    @id = id
    @email = email
    @password = password
  end

end
