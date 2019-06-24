# frozen_string_literal: true

require 'pg'

p 'Setting up test database...'

def prepare_test_database
  con = PG.connect(dbname: 'prepr_test')
  con.exec('DROP TABLE IF EXISTS posts;')
  con.exec('DROP TABLE IF EXISTS users;')
  con.exec(IO.read('db/migrations/01_setup_users_posts_tables.sql'))
end
