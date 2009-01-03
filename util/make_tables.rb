#! /usr/bin/ruby

require File.join(File.dirname(__FILE__), '..', 'config', 'init')

DB.create_table :players do
  primary_key :id
  text :name, :null => false, :unique => true
  integer :rating, :null => false
  boolean :external, :default => false
end

DB.create_table :games do
  primary_key :id
  foreign_key :left_id, :players
  foreign_key :right_id, :players
  text :winner, :null => false
end
