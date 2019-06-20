require 'pg'

p 'Setting up test database...'

def prepare_test_database
  con = PG.connect(dbname: 'peepr_test')
  con.exec("DROP TABLE IF EXISTS posts; CREATE TABLE posts(id SERIAL PRIMARY KEY, body VARCHAR(280)); ALTER TABLE posts ADD COLUMN title VARCHAR(100);
")
end
