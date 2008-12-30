require 'rubygems'
require 'sequel'

require 'logger'

require File.dirname(__FILE__) + '/../lib/ratings.rb'

def db_connection
  Sequel.sqlite(File.dirname(__FILE__) + '/../data/ratings.db', :loggers => [ Logger.new($stdout) ])
end

if ENV['ENVIRONMENT'] == 'test'
  DB = Sequel.sqlite
else
  DB = db_connection
end
