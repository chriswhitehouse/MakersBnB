require 'bcrypt'

class User

  def self.create(email:, password:)
    encrypted_password = BCrypt::Password.create(password)
    result = DatabaseConnection.query("INSERT INTO users (email, password) VALUES ('#{email}', '#{encrypted_password}')RETURNING id, email, password;").first
    User.new(id: result['id'],email: result['email'],password: result['password'])
  end

  def self.find(id:)
    return nil unless id
    result = DatabaseConnection.query("SELECT * FROM users WHERE id = #{id}")
    User.new(
      id: result[0]['id'],
      email: result[0]['email'],
      password: result[0]['password']
    )
  end

  attr_reader :id, :email, :password


  def initialize(id:, email:, password:)
    @id = id
    @email = email
    @password = password
  end

end
