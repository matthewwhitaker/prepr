require 'bcrypt'

class User
  attr_reader :email, :username, :id
  def initialize(email:, username:, id:)
    @email = email
    @username = username
    @id = id
  end

  def self.create(email:, username:, password:)
    encrypted_password = BCrypt::Password.create(password)
    result = DatabaseConnection.query("INSERT INTO users (id, email, username, password) VALUES(DEFAULT, '#{email}', '#{username}', '#{encrypted_password}') RETURNING id, email, username, password;")
    User.new(id: result[0]["id"], email: result[0]["email"], username: result[0]["username"])
  end

  def self.find(id:)
    return nil unless id
    result = DatabaseConnection.query("SELECT * FROM users WHERE id = '#{id}';")
    User.new(id: result[0]["id"], email: result[0]["email"], username: result[0]["username"])
  end

  def self.authenticate(email:, password:)
    result = DatabaseConnection.query("SELECT * FROM users WHERE email = '#{email}';")
    return unless result.any?
    return unless BCrypt::Password.new(result[0]['password']) == password
    return User.new(id: result[0]['id'], email: result[0]['email'], username: result[0]['username'])
  end
end
