class AddDefaultToAmount < ActiveRecord::Migration[7.1]
  def change
    change_column_default :carts, :amount, 2
  end
end
