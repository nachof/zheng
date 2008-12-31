require 'rubygems'
require 'sequel'

require 'logger'

if ENV['ENVIRONMENT'] == 'test'
  logger = Logger.new(File.dirname(__FILE__) + '/../logs/test.log')
  DB = Sequel.sqlite "", :loggers => [ logger ]
else
  logger = Logger.new(File.dirname(__FILE__) + '/../logs/ratings.log')
  DB = Sequel.sqlite(File.dirname(__FILE__) + '/../data/ratings.db', :loggers => [ logger ])
end

require File.dirname(__FILE__) + '/../lib/ratings.rb'
