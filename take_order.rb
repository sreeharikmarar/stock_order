require_relative 'order'

class TakeOrder
	def initialize
		choose do |menu|
			say("\n\n============================ Stock Order Form ============================")
      		menu.prompt = "Please select Type 'Buy' or 'Sell' to place order"
        	menu.choice(:Buy) { Order.new("buy").execute }
      		menu.choice(:Sell) { Order.new("sell").execute }
      		menu.choice(:Quit, "Exit program.") { exit }
    	end	
    end
end