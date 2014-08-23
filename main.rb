require 'rubygems'
require 'active_record'
require 'nokogiri'
require 'active_record'
require 'mysql2'


ActiveRecord::Base.establish_connection ({
  :adapter => "mysql2",
  :host => "localhost",
  :username => "root",
  :password => "password",
  :database => "test"})




class User < ActiveRecord::Base
      attr_accessor :name , :email
    

end


class Stock
 
  def initialize
    
    @prompt = ["name","email"]
    @user = User.new
    
  end
  def inputs
     u = User.new
     @prompt.each do |s|
       puts "Enter your : #{s}"
       @user["#{s}"] = gets.chomp
     end
    @user.save 
  end
end

s=Stock.new
s.inputs


