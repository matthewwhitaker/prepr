require 'pg'
require 'db_connection'

class Post
  attr_reader :id, :title, :body

  def initialize(id:, title:, body:)
    @id  = id
    @title = title
    @body = body
  end

  def self.all
    posts = []
    DatabaseConnection.query('SELECT * FROM posts').each { |row| posts << Post.new(id: row['id'], title: row['title'], body: row['body']) }
    posts
  end

  def self.add(body:, title:)
    result = DatabaseConnection.query("INSERT INTO posts (id, body, title) VALUES(DEFAULT, '#{body}', '#{title}') RETURNING id, body, title")
    Post.new(id: result[0]['id'], title: result[0]['title'], body: result[0]['body'])
  end

  def self.delete(id:)
    DatabaseConnection.query("DELETE FROM posts WHERE id = #{id}")
  end

  def self.update(id:, title:, body:)
    DatabaseConnection.query("UPDATE posts SET title = '#{title}', body = '#{body}' WHERE id = #{id}")
  end

  def self.find(id:)
    result = DatabaseConnection.query("SELECT * FROM posts WHERE id = #{id}")
    Post.new(id: result[0]['id'], title: result[0]['title'], body: result[0]['body'])
  end
end
