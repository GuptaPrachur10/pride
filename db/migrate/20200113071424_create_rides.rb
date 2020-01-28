class CreateRides < ActiveRecord::Migration[5.2]
  def change
    create_table :rides do |t|
      t.string :from
      t.string :to
      t.datetime :date
      t.references :driver, foreign_key: true

      t.timestamps
    end
  end
end
