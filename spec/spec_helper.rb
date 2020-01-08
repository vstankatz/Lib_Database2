require 'rspec'
require 'pg'
require 'book'
require 'patron'
require 'pry'

DB = PG.connect({:dbname => 'library_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM books *;")
    DB.exec("ALTER SEQUENCE books_id_seq RESTART WITH 1;")
    DB.exec("DELETE FROM patrons *;")
    DB.exec("ALTER SEQUENCE patrons_id_seq RESTART WITH 1;")
    DB.exec("DELETE FROM authors *;")
    DB.exec("ALTER SEQUENCE authors_id_seq RESTART WITH 1;")
  end
end
