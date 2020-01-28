class ChangePriceToBeFloatInRides < ActiveRecord::Migration[5.2]
  def change
    change_column :rides, :price, :float
  end
end
