require 'pg'
require './lib/db_connection'

class Post
  attr_reader :id, :title, :body, :user_id, :username

  def initialize(id:, title:, body:, user_id:, username:)
    @id = id
    @title = title
    @body = body
    @user_id = user_id
    @username = username
  end

  def self.all
    posts = []
    DatabaseConnection.query('SELECT p.id, p.title, p.body, p.user_id, u.username FROM posts p LEFT OUTER JOIN users u on p.user_id = u.id').each { |row| posts << Post.new(id: row['id'], title: row['title'], body: row['body'], user_id: row['user_id'], username: row['username']) }
    posts
  end

  def self.add(body:, title:, user_id:)
    result = DatabaseConnection.query("INSERT INTO posts (id, body, title, user_id) VALUES(DEFAULT, '#{body}', '#{title}', '#{user_id}') RETURNING id, body, title, user_id")
    Post.new(id: result[0]['id'], title: result[0]['title'], body: result[0]['body'], user_id: result[0]['user_id'], username: result[0]['username'])
  end

  def self.delete(id:)
    DatabaseConnection.query("DELETE FROM posts WHERE id = #{id}")
  end

  def self.update(id:, title:, body:)
    DatabaseConnection.query("UPDATE posts SET title = '#{title}', body = '#{body}' WHERE id = #{id}")
  end

  def self.find(id:)
    result = DatabaseConnection.query("SELECT p.id, p.title, p.body, p.user_id, u.username FROM posts p LEFT OUTER JOIN users u on p.user_id = u.id WHERE p.id = #{id}")
    Post.new(id: result[0]['id'], title: result[0]['title'], body: result[0]['body'], user_id: result[0]['user_id'], username: result[0]['username'])
  end
end
