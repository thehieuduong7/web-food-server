class CreateProductImages < ActiveRecord::Migration[7.0]
  def change
    create_table :product_images do |t|
      t.text :url
      t.integer :product_id
      t.timestamps
    end
  end
end
