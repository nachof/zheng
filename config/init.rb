require 'rubygems'
require 'sequel'

require 'logger'


def db_connection
  Sequel.sqlite(File.dirname(__FILE__) + '/../data/ratings.db', :loggers => [ logger ])
end

if ENV['ENVIRONMENT'] == 'test'
  logger = Logger.new(File.dirname(__FILE__) + '/../logs/test.log')
  DB = Sequel.sqlite "", :loggers => [ logger ]
else
  logger = Logger.new(File.dirname(__FILE__) + '/../logs/ratings.log')
  DB = db_connection
end

require File.dirname(__FILE__) + '/../lib/ratings.rb'
