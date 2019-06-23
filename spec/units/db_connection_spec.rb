require 'db_connection'

describe DatabaseConnection do
  describe '.setup_connection' do
    it 'sets up a connection' do
      expect(PG).to receive(:connect).with(dbname: 'prepr_test')
      DatabaseConnection.setup_connection('prepr_test')
    end
  end

  describe '.query' do
    it 'executes a query on the database' do
      con = DatabaseConnection.setup_connection('prepr_test')
      expect(con).to receive(:exec).with('SELECT * FROM posts;')
      DatabaseConnection.query('SELECT * FROM posts;')
    end
  end
end
