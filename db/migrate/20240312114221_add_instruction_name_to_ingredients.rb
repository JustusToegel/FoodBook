class AddInstructionNameToIngredients < ActiveRecord::Migration[7.1]
  def change
    add_column :ingredients, :instruction_name, :string
  end
end
