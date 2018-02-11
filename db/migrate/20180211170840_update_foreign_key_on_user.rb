class UpdateForeignKeyOnUser < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :recipes, :users
    add_foreign_key :recipes, :users, on_delete: :cascade
  end
end
