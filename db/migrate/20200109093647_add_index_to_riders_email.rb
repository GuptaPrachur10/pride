class AddIndexToRidersEmail < ActiveRecord::Migration[5.2]
  def change
    add_index :riders, :email, unique: true
  end
end
