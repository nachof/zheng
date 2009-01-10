require 'rubygems'
require 'sequel'
require 'erb'

require 'shellwords' # Needed for parsing the script action

require 'logger'

require 'ftools'

Dir.chdir File.join(File.dirname(__FILE__), '..')

def config
  $__config ||= (
    user_conf = File.expand_path('~/.zheng.yaml')
    default_conf = File.join(File.dirname(__FILE__), 'default.yaml')
    File.copy(default_conf, user_conf) unless File.exist? user_conf
    YAML.load(ERB.new(File.read(user_conf)).result) 
  )
end

if ENV['ENVIRONMENT'] == 'test'
  logger = Logger.new(File.join(File.dirname(__FILE__), '..', 'logs', 'test.log'))
  DB = Sequel.sqlite "", :loggers => [ logger ]
else
  DB = Sequel.connect(config[:database])
end

require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'zheng'))

# This will create the tables only if they don't already exist.
# This should be done using Sequel's table_exists? method, but it always returns true.
begin
  DB.from(:players).first
rescue
  Zheng::Player.create_table
  Zheng::Game.create_table
end
