class CreateDesks < ActiveRecord::Migration[5.2]
  def change
    create_table :desks do |t|
      
      t.integer :desk_reference
      t.string :day
      t.string :time_slot
      t.integer :user_id

      t.timestamps
    end
  end
end
