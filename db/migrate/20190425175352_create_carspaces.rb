class CreateCarspaces < ActiveRecord::Migration[5.2]
  def change
    create_table :carspaces do |t|
      
      t.integer :space_reference
      t.integer :space_owner_id
      t.integer :taken_user_id
      t.string :status

      t.timestamps
    end
  end
end
