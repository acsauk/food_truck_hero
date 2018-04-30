class CreateMeals < ActiveRecord::Migration[5.1]
  def change
    create_table :meals do |t|
      t.string :name,             null: false
      t.integer :portions,        null: false
      t.float :price_per_portion, null: false

      t.timestamps
    end
  end
end
