class CreateStockOrders < ActiveRecord::Migration
  def up
	create_table :stock_orders do |t|
		t.string  :side
		t.string  :company
		t.integer :quantity
		t.integer :rem_quantity
		t.string  :status
	end
  end

  def down
	drop_table :stock_orders
  end
end
