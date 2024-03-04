class CreateIngredients < ActiveRecord::Migration[7.1]
  def change
    create_table :ingredients do |t|
      t.string :name
      t.integer :size
      t.integer :price

      t.timestamps
    end
  end
end
