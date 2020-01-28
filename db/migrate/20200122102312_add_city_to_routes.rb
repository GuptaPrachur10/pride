class AddCityToRoutes < ActiveRecord::Migration[5.2]
  def change
    add_column :routes, :from_city, :string
    add_column :routes, :to_city, :string
    add_column :routes, :distance, :float
  end
end
