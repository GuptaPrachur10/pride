class AddIndexToDriversMobile < ActiveRecord::Migration[5.2]
  def change
    add_index :drivers, :mobile, unique: true
  end
end
