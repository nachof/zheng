#! /usr/bin/ruby

require File.join(File.dirname(__FILE__), '..', 'config', 'init')

Zheng::Player.create_table
Zheng::Game.create_table
