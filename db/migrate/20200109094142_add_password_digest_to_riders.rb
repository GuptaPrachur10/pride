class AddPasswordDigestToRiders < ActiveRecord::Migration[5.2]
  def change
    add_column :riders, :password_digest, :string
  end
end
