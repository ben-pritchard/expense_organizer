require('rspec')
require('expense')
require('category')
require('pry')
require('pg')

DB = PG.connect({:dbname => 'budget_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM expenses *;")
    DB.exec("DELETE FROM categories *;")
  end
end
