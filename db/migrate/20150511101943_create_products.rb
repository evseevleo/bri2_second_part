class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.string :image_url
      t.decimal :price
      t.references :category

      t.timestamps
    end
    add_index :products, :category_id

    add_foreign_key :products, :categories
  end
end
