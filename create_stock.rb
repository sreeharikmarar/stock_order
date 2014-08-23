class CreateStock

  def initialize(order)
	StockOrder.execute_order(order)
	display_orders
  end 
  def display_orders
	say("=======================================================================")
	say("id\tside\tcompany\tquantity\trem_quantity\tstatus")
	say("=======================================================================")
	StockOrder.all.each do |s|
		say("#{s.id}\t#{s.side}\t#{s.company}\t#{s.quantity}\t\t#{s.rem_quantity}\t\t#{s.status}")
	end
	say("========================================================================")
  end

end
