class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      t.integer :rider_id
      t.integer :driver_id
      t.integer :status

      t.timestamps
    end
    add_index :relationships, :rider_id
    add_index :relationships, :driver_id
    add_index :relationships, [:rider_id, :driver_id], unique: true
  end
end
