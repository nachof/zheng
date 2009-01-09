#! /usr/bin/ruby

require File.join(File.dirname(__FILE__), '..', 'config', 'init')

# This will create the tables only if they don't already exist.
# This should be done using Sequel's table_exists? method, but it always returns true.
begin
  DB.from(:players).first
rescue
  Zheng::Player.create_table
  Zheng::Game.create_table
end
