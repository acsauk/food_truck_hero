class AddUseByDaysToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :use_by_days, :int, null: false, default: 1
  end
end
