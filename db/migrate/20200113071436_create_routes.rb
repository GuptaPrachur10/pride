class CreateRoutes < ActiveRecord::Migration[5.2]
  def change
    create_table :routes do |t|
      t.string :from
      t.string :to
      t.datetime :date
      t.references :rider, foreign_key: true

      t.timestamps
    end
  end
end
