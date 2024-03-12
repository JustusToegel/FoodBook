class ChangePriceTypeInIngredients < ActiveRecord::Migration[7.1]
  def change
    change_column :ingredients, :price, :float
  end
end
