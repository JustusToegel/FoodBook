class AddPrepTimeToMeals < ActiveRecord::Migration[7.1]
  def change
    add_column :meals, :prep_time, :integer
  end
end
