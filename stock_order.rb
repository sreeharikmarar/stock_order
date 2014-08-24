#require 'active_record'
class StockOrder < ActiveRecord::Base
      

	def self.execute_order(current_order)
		@current_order = current_order
		@prev_order = StockOrder.where("company = '#{@current_order.company}' and status = 'open'").last
		if @prev_order 
			if eligible_for_sale?
				if @prev_order.rem_quantity < @current_order.quantity
					rem_quantity = (@current_order.quantity - @prev_order.rem_quantity)
					@current_order.open!(rem_quantity)
					@prev_order.close!
				else
					@prev_order.open!(@current_order.quantity)
					@current_order.close!
				end		
			else
				rem_quantity = (@current_order.quantity + @prev_order.rem_quantity)
				@current_order.open!(rem_quantity)
			   	@prev_order.close!
			end
		else
			@current_order.open!(@current_order.quantity )
		end
    end

	def self.eligible_for_sale?
		(@prev_order.buy? && @current_order.sell?) || (@prev_order.sell? && @current_order.buy?)
	end

	def buy?
		side == 'buy'
	end

	def sell?
		side == 'sell'
	end

	def open?
		status == 'open'
	end

	def closed?
		status == 'closed'
	end

	def open!(current_quantity)	
		self.rem_quantity = (self.rem_quantity - current_quantity )
		self.status = 'open'
		self.save!
	end

	def close!
		self.rem_quantity = 0
		self.status = "closed"
		self.save!
	end
	
end
