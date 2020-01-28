class AddIndexToRidersMobile < ActiveRecord::Migration[5.2]
  def change
    add_index :riders, :mobile, unique: true
  end
end
