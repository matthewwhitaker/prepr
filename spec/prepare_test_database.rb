require 'pg'

p 'Setting up test database...'

def prepare_test_database
  con = PG.connect(dbname: 'peepr_test')
  con.exec("DROP TABLE IF EXISTS posts;")
  con.exec("DROP TABLE IF EXISTS users;")
  con.exec("CREATE TABLE posts(id SERIAL PRIMARY KEY, title VARCHAR(100), body VARCHAR(280));")
  con.exec("CREATE TABLE users(id SERIAL PRIMARY KEY, email VARCHAR(60), username VARCHAR(100), password VARCHAR(140));")
end
