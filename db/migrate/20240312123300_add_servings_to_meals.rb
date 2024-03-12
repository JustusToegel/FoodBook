class AddServingsToMeals < ActiveRecord::Migration[7.1]
  def change
    add_column :meals, :servings, :integer
  end
end
