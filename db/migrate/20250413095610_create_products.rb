class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :sku
      t.decimal :price
      t.text :images
      t.integer :quantity
      t.boolean :unlimited
      t.string :status
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
