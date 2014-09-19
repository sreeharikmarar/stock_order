require_relative 'take_order'
require_relative 'display_orders'
require_relative 'stock_order'

class Order
	 
	def initialize(type)

		@order = Hash.new
		@order["side"] = type
    @order["company"]  = ask("Company?",String) { |c| c.validate = /[a-zA-Z0-9_]/ }
		@order["rem_quantity"] = @order["quantity"] = ask("Quantity?",Integer) { |q| q.in = 0..100000 }

  end

  def execute
  		
  	StockOrder.execute_order(self)

		choose do |menu|
		    say("="*75)
     		menu.prompt = "Please select 1.Continue for Next order | 2. Display all Order Status | 3. Quit"
     		menu.choice(:Continue, "Continue Next Order") { TakeOrder.new }
     		menu.choice(:Display, "Display All Order Status") { DisplayOrders.new }
     		menu.choice(:Quit, "Exit program.") { exit }
    end

  end

  def order
      @order
  end

  def quantity
  		order["quantity"]
  end

  def rem_quantity
      order["rem_quantity"]
  end
  
  def status
      order["status"]
  end
  
  def self.side
  		order["side"]
  end

  def company
  		order["company"]
  end

  def sell?
  		order["side"] == 'sell'
  end

  def buy?
  		order["side"] == 'buy'
  end

  def open!(rem_quantity)
      order["rem_quantity"] = rem_quantity
      order["status"] = 'open'
      StockOrder.create(order)
  end

  def close!
      order["rem_quantity"] = 0
      order["status"] = "closed"
      StockOrder.create(order)
  end

  def update_rem_quantity!(quantity)
    order["rem_quantity"] = quantity
    self
  end

end