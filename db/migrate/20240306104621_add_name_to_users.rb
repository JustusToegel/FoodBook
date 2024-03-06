class AddNameToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :name, :string
    add_column :users, :bio, :text
    add_column :users, :description, :string
    add_column :users, :instagram, :string
    add_column :users, :you_tube, :string
  end
end
