class CreateGears < ActiveRecord::Migration[7.0]
  def change
    create_table :gears do |t|
      t.string :name
      t.string :description
      t.string :category
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
