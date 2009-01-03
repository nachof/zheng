require 'rubygems'
require 'sequel'

require 'shellwords' # Needed for parsing the script action

require 'logger'

if ENV['ENVIRONMENT'] == 'test'
  logger = Logger.new(File.dirname(__FILE__) + '/../logs/test.log')
  DB = Sequel.sqlite "", :loggers => [ logger ]
else
  logger = Logger.new(File.dirname(__FILE__) + '/../logs/zheng.log')
  DB = Sequel.sqlite(File.dirname(__FILE__) + '/../data/zheng.db', :loggers => [ logger ])
end

require File.dirname(__FILE__) + '/../lib/zheng.rb'
