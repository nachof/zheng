require 'rubygems'
require 'sequel'

require 'logger'

def db_connection
  Sequel.sqlite(File.dirname(__FILE__) + '/../data/ratings.db', :loggers => [ Logger.new($stdout) ])
end

if ENV['ENVIRONMENT'] == 'test'
  DB = Sequel.sqlite
  puts "Testing"
else
  puts "Not testing"
  DB = db_connection
end
