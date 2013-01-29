class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.integer :house_id
      t.integer :user_id

      t.timestamps
    end
		
		add_index :memberships, :house_id
		add_index :memberships, :user_id
		add_index :memberships, [:house_id, :user_id], unique: true
  end
end
