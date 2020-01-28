class AddIndexToDriversEmail < ActiveRecord::Migration[5.2]
  def change
    add_index :drivers, :email, unique: true
  end
end
