class AddPriceToGear < ActiveRecord::Migration[7.0]
  def change
    add_column :gears, :price, :decimal
  end
end
