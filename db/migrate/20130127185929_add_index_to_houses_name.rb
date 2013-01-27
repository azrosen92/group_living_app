class AddIndexToHousesName < ActiveRecord::Migration
  def change
		add_index :houses, :name, unique: true
  end
end
