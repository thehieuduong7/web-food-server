class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.float :price
      t.integer :total_sold
      t.float :percent_sale
      t.boolean :is_active
      t.timestamps
    end
  end
end
