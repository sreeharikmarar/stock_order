require 'rubygems'
require 'active_record'
require 'mysql2'
require 'highline/import'
require_relative "stock_order"
require_relative "create_stock"

ActiveRecord::Base.establish_connection ({
  :adapter => "mysql2",
  :host => "localhost",
  :username => "root",
  :password => "password",
  :database => "test"})


class Main
  def initialize
	choose do |menu|
      		menu.prompt = "Please select Type 'Buy' or 'Sell' to place order OR 'Quit' to exit"
      		menu.choice(:Buy) { make_order("buy") }
      		menu.choice(:Sell) { make_order("sell") }
      		menu.choice(:Quit, "Exit program.") { exit }
    	end
  end

  private

  def make_order(type)
        order = {}
        case type
	when "buy" then order["side"] = "buy"
	when "sell" then order["side"] = "sell"
	end
  	order["company"]  = ask("Company?",String) { |c| c.validate = /[a-zA-Z0-9_]/ }
	order["quantity"] = ask("Quantity?",Integer) { |q| q.in = 0..10000 }
	CreateStock.new(order)
  end
end



Main.new



