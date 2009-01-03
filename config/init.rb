require 'rubygems'
require 'sequel'

require 'shellwords' # Needed for parsing the script action

require 'logger'

if ENV['ENVIRONMENT'] == 'test'
  logger = Logger.new(File.join(File.dirname(__FILE__), '..', 'logs', 'test.log'))
  DB = Sequel.sqlite "", :loggers => [ logger ]
else
  logger = Logger.new(File.join(File.dirname(__FILE__), '..', 'logs', 'zheng.log'))
  DB = Sequel.sqlite(File.join(File.dirname(__FILE__), '..', 'data', 'zheng.db'), :loggers => [ logger ])
end

require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'zheng'))
