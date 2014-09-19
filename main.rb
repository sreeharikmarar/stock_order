require 'rubygems'
require 'active_record'
require 'mysql2'
require 'highline/import'
require_relative 'take_order'

ActiveRecord::Base.establish_connection ({
  :adapter => "mysql2",
  :host => "localhost",
  :username => "root",
  :password => "password",
  :database => "stock_db"})

begin
  TakeOrder.new
rescue => ex
  puts "Some Exception has occured in #{ex.class} : #{ex.message}"
end