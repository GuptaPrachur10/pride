class AddPriceToRide < ActiveRecord::Migration[5.2]
  def change
    add_column :rides, :price, :integer
  end
end
