require_relative "take_order"

class DisplayOrders
	def initialize
		say("\n========================== Your Order Summary ===========================")
		say("id\tside\tcompany\tquantity\trem_quantity\tstatus")
		say("=========================================================================")
		StockOrder.all.each do |s|
			say("#{s.id}\t#{s.side}\t#{s.company}\t#{s.quantity}\t\t#{s.rem_quantity}\t\t#{s.status}")
		end
		TakeOrder.new
	end
end