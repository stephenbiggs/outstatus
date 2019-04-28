class AddStatusToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :status, :string
    add_column :users, :comments, :string
  end
end
