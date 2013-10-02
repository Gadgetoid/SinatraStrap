ROOT = File.expand_path File.dirname(__FILE__)
DB_NAME = 'data.db'

require 'rubygems'
require 'bundler/setup'
Bundler.require

require './app.rb'
run App