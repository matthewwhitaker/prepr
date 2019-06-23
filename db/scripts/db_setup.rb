require './lib/db_connection'

if ENV['ENVIRONMENT'] == 'test'
  DatabaseConnection.setup_connection('prepr_test')
else
  DatabaseConnection.setup_connection('prepr')
end
