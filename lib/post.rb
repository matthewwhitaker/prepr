require 'pg'

class Post
  attr_reader :id, :title, :body

  def initialize(id:, title:, body:)
    @id  = id
    @title = title
    @body = body
  end

  def self.all
    if ENV['ENVIRONMENT'] == 'test'
      con = PG.connect(dbname: 'peepr_test')
    else
      con = PG.connect(dbname: 'peepr')
    end

    posts = []
    con.exec('SELECT * FROM posts').each { |row| posts << Post.new(id: row['id'], title: row['title'], body: row['body']) }
    posts
  end

  def self.add(body:, title:)
    if ENV['ENVIRONMENT'] == 'test'
      con = PG.connect(dbname: 'peepr_test')
    else
      con = PG.connect(dbname: 'peepr')
    end
    result = con.exec("INSERT INTO posts (id, body, title) VALUES(DEFAULT, '#{body}', '#{title}') RETURNING id, body, title")
    Post.new(id: result[0]['id'], title: result[0]['title'], body: result[0]['body'])
  end

  def self.delete(id:)
    if ENV['ENVIRONMENT'] == 'test'
      con = PG.connect(dbname: 'peepr_test')
    else
      con = PG.connect(dbname: 'peepr')
    end
    con.exec("DELETE FROM posts WHERE id = #{id}")
  end

  def self.update(id:, title:, body:)
    if ENV['ENVIRONMENT'] == 'test'
      con = PG.connect(dbname: 'peepr_test')
    else
      con = PG.connect(dbname: 'peepr')
    end
    con.exec("UPDATE posts SET title = '#{title}', body = '#{body}' WHERE id = #{id}")
  end

  def self.find(id:)
    if ENV['ENVIRONMENT'] == 'test'
      con = PG.connect(dbname: 'peepr_test')
    else
      con = PG.connect(dbname: 'peepr')
    end
    result = con.exec("SELECT * FROM posts WHERE id = #{id}")
    Post.new(id: result[0]['id'], title: result[0]['title'], body: result[0]['body'])
  end
end
