class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.string :first_name
      t.string :last_name
      t.boolean :gender # male true, felame false
      t.date :dob
      t.string :phone
      t.text :address
      t.text :avatar
      t.boolean :is_active, default: true
      t.boolean :is_admin, default: false
      t.timestamps
    end
  end
end
