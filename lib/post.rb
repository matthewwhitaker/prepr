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

end
