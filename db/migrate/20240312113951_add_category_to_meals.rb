class AddCategoryToMeals < ActiveRecord::Migration[7.1]
  def change
    add_column :meals, :category, :string
  end
end
