require './lib/db_connection'

if ENV['ENVIRONMENT'] == 'test'
  DatabaseConnection.setup_connection('peepr_test')
else
  DatabaseConnection.setup_connection('peepr')
end
