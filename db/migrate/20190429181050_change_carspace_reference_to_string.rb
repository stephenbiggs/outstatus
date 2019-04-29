class ChangeCarspaceReferenceToString < ActiveRecord::Migration[5.2]
  def change
      change_column :carspaces, :space_reference, :string
  end
end
