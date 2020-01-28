class AddCityToRides < ActiveRecord::Migration[5.2]
  def change
    add_column :rides, :from_city, :string
    add_column :rides, :to_city, :string
    add_column :rides, :distance, :float
  end
end
