# frozen_string_literal: true

require 'pg'

class DatabaseConnection
  def self.setup_connection(dbname)
    p "connected to: #{dbname}"
    @connection = PG.connect(dbname: dbname)
  end

  def self.query(query_string)
    @connection.exec(query_string)
  end
end
