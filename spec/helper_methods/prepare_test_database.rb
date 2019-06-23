require 'pg'

p 'Setting up test database...'

def prepare_test_database
  con = PG.connect(dbname: 'peepr_test')
  con.exec('DROP TABLE IF EXISTS posts;')
  con.exec('DROP TABLE IF EXISTS users;')
  con.exec(IO.read('db/migrations/01_create_posts_table.sql'))
  con.exec(IO.read('db/migrations/02_add_title_to_posts.sql'))
  con.exec(IO.read('db/migrations/03_create_users_table.sql'))
  con.exec(IO.read('db/migrations/04_add_user_id_to_posts.sql'))
end
