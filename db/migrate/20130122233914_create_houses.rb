class CreateHouses < ActiveRecord::Migration
  def change
    create_table :houses do |t|
      t.string :name
      t.integer :admin_id

      t.timestamps
    end
  end
end
