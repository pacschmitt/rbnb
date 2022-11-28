class CreatePages < ActiveRecord::Migration[7.0]
  def change
    create_table :pages do |t|
      t.string :about
      t.string :html
      t.string :erb

      t.timestamps
    end
  end
end
